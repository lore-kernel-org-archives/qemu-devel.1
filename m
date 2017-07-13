Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1dVWom-0003HI-0O
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1dVWoi-0005bu-Tb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:37:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.vnet.ibm.com>)
	id 1dVWoi-0005aY-Iw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:37:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D5XwNm082394
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 01:37:33 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3rg7nf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 01:37:33 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 06:37:30 +0100
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-2-git-send-email-borntraeger@de.ibm.com>
	<20170712154903.12ae15f9@dhcp-192-215.str.redhat.com>
From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 07:37:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170712154903.12ae15f9@dhcp-192-215.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="265AodmwitDGrSlseAwvVCVsNIojDm5Tq"
Message-Id: <7363e83e-6230-a595-e295-983efc45e6af@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] s390x/kvm: Rework cmma management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--265AodmwitDGrSlseAwvVCVsNIojDm5Tq
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <7363e83e-6230-a595-e295-983efc45e6af@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/11] s390x/kvm: Rework cmma management
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
 <1499864265-144136-2-git-send-email-borntraeger@de.ibm.com>
 <20170712154903.12ae15f9@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170712154903.12ae15f9@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.07.2017 15:49, Cornelia Huck wrote:
> On Wed, 12 Jul 2017 14:57:35 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> From: Janosch Frank <frankja@linux.vnet.ibm.com>
>>
>> Let's keep track of cmma enablement and move the mem_path check into
>> the actual enablement. This now also warns users that do not use
>> cpu-models about disabled cmma when using huge pages.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu.h |  1 +
>>  target/s390x/kvm.c | 26 +++++++++++++++++---------
>>  2 files changed, 18 insertions(+), 9 deletions(-)
>=20
>> @@ -177,6 +179,11 @@ int kvm_s390_set_mem_limit(KVMState *s, uint64_t =
new_limit, uint64_t *hw_limit)
>>      return kvm_vm_ioctl(s, KVM_SET_DEVICE_ATTR, &attr);
>>  }
>> =20
>> +int kvm_s390_cmma_active(void)
>> +{
>> +    return active_cmma;
>> +}
>=20
> This is rather "has cmma ever been enabled"...
>=20
>> +
>>  static bool kvm_s390_cmma_available(void)
>>  {
>>      static bool initialized, value;
>> @@ -197,7 +204,7 @@ void kvm_s390_cmma_reset(void)
>>          .attr =3D KVM_S390_VM_MEM_CLR_CMMA,
>>      };
>> =20
>> -    if (mem_path || !kvm_s390_cmma_available()) {
>> +    if (!kvm_s390_cmma_active()) {
>>          return;
>>      }
>=20
> ...as you don't clear it on reset, right?

I guess you mean KVM_S390_VM_MEM_CLR_CMMA, yes that only
manipulates/clears the PGSTE values but can not disable the cmma
facility. Disabling that on a running VM would be "interesting" at best.

>=20
> Confused me a bit at first, but
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!



--265AodmwitDGrSlseAwvVCVsNIojDm5Tq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJZZwcVAAoJEBcO/8Q8ZEV598YP+IaNe8lsOlnTxgupE7ycLy1b
taEfFvdyT2qxEZSitnL3/GKwl/65CNlcgg5+Qxf3PaE/SW0161R1kvorpm94xoA9
Mt8ln2QL1gWQwjcFof2ZA664eGV40ulNysKqdCQHheZZw6k2/7klAu85GGY9+fNq
w0wMfcGkNw2jC9bAtdMaYMq8u94QYA0HMmZHaZ+6ACyWxNMQeMM2UmyOwg+ARP5E
MtgyNlEx3GCC62Q1CVsnv4xO0i0j7TMfAIzRabLiAPDZZ45F2Nqs9ZCwH8oMTpGe
yBEZU2A76XC59M30elKbkrHFoM35DNkOw+EEYU3k8jbFkwxW3Yj8RwcU5lvlkI5x
9xbB4YEQIGnlVJtJchq1lE99zIQdmZ/K+HBYV60sF6Y4iRzug7257/JCodLo8i9p
OUJUQc+esRrG/+teV/zNwTqvoIduBoBEjCd7iHSlxora0DnUtNEBq9pvE8dgoy9q
sdi9M4yez0iJTPNcuFykLJWqpsKBuqcnXATsiie7N3PZn9O4uj/J/8VpssyXtezZ
0hYRsiEZvUOyP8jwKFFMVz2e449Fr9ZzOixuYlEHC+mUK8AiwAmcvlG7+1v6uaS9
lijF4mJ0930tC0zrUmekKJ8avpGKcsnYuHGCQVngJLscZxxK2KOj1LIcLr5PH3sz
qhSTQJZZU+J+IyeZBY8=
=rtg6
-----END PGP SIGNATURE-----

--265AodmwitDGrSlseAwvVCVsNIojDm5Tq--
