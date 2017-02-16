Received: from eggs.gnu.org ([2001:4830:134:3::10]:42796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceOHv-0001AO-S0
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceOHs-0004jH-L2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:48:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceOHs-0004jC-Cv
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:48:04 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
	<4d92b9f92d2f5b702c23bf135222dfb226ec94a7.1487224954.git.ben@skyportsystems.com>
	<20170216104310.7bc059e2@nial.brq.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a66b6662-b4d2-c4f2-f14e-2e90d5238e0a@redhat.com>
Date: Thu, 16 Feb 2017 09:48:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170216104310.7bc059e2@nial.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ul9rIifwt830gWG9X23Luh19mMIIM0jrA"
Subject: Re: [Qemu-devel] [PATCH v7 1/8] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, ben@skyportsystems.com
Cc: lersek@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ul9rIifwt830gWG9X23Luh19mMIIM0jrA
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, ben@skyportsystems.com
Cc: lersek@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Message-ID: <a66b6662-b4d2-c4f2-f14e-2e90d5238e0a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/8] linker-loader: Add new 'write
 pointer' command
References: <cover.1487224954.git.ben@skyportsystems.com>
 <4d92b9f92d2f5b702c23bf135222dfb226ec94a7.1487224954.git.ben@skyportsystems.com>
 <20170216104310.7bc059e2@nial.brq.redhat.com>
In-Reply-To: <20170216104310.7bc059e2@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2017 03:43 AM, Igor Mammedov wrote:

>> +++ b/hw/acpi/bios-linker-loader.c
>> @@ -78,6 +78,21 @@ struct BiosLinkerLoaderEntry {
>>              uint32_t length;
>>          } cksum;
>> =20
>> +        /*
>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating=
 from
>> +         * @dest_file) at @wr_pointer.offset, by adding a pointer to
>> +         * @src_offset within the table originating from @src_file.
>> +         * 1,2,4 or 8 byte unsigned addition is used depending on
>> +         * @wr_pointer.size.
>> +         */
>> +        struct {
>> +            char dest_file[BIOS_LINKER_LOADER_FILESZ];
>> +            char src_file[BIOS_LINKER_LOADER_FILESZ];
>> +            uint32_t dst_offset;
>> +            uint32_t src_offset;
>> +            uint8_t size;
>> +        } wr_pointer;
>> +
>>          /* padding */
>>          char pad[124];
> Shouldn't padding be reduced by 4 bytes to keep=20
> sizeof(BiosLinkerLoaderEntry) the same as before patch,
> so that old bios would be able to skip this unknown command
> and read the next at the right offset?

No, because you are in the middle of a union rather than a struct (the
outer BiosLinkerLoaderEntry struct size is determined by the largest
member of the union, which is 'char pad[124]'; the new wr_pointer
addition to the union does not change the size of the union).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ul9rIifwt830gWG9X23Luh19mMIIM0jrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpcmxAAoJEKeha0olJ0NqmpIH+gKz6tdBuJAx5UnRb3yXzgv/
axiJEMGssCZT510lk2+idgQSnzI/yPlWfCuwQRp4zS60QO6fGG6ejtI7EfXL2GRB
Pg820jmR0rv3dyR4iG5gf+rOgyZSsGqMafWk0EfzOy1qZ9Orf+D2JWLJDSc3lpzY
HpkBGM2243zF4OAdWwaIZTwHcpRHBv6HR0bdmdUpQbrCsss3fxynygLC+35g0u+E
Mv+kBcCSwBXoO6WtI3RHfOwvhj1eRmLYHfDAzz6PXsoL2WYd/+iXWLvRFgBYjyaL
gkld/f0ngVkZVuXtBvzMnnYzHfVYZGPdSYtbTEUlw3oic/pfzXSi9JYgKtb9iw4=
=ER33
-----END PGP SIGNATURE-----

--Ul9rIifwt830gWG9X23Luh19mMIIM0jrA--
