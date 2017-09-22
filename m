Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvTHi-0008TT-Um
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvTHe-0004TS-IC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:06:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dvTHe-0004T5-BS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 15:06:42 -0400
References: <20170922150410.20689-1-pbonzini@redhat.com>
	<CAFEAcA9NBEwdTRk2XD3CZ9+V6O-RqMMSJMGzDQwHbzgd46UU4A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37185b8c-b49d-9507-289f-935ba67d6d51@redhat.com>
Date: Fri, 22 Sep 2017 21:06:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9NBEwdTRk2XD3CZ9+V6O-RqMMSJMGzDQwHbzgd46UU4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/32] Misc patches for 2017-09-22 (v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22/09/2017 20:09, Peter Maydell wrote:
> On 22 September 2017 at 16:04, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>> The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be9=
8dae6:
>>
>>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into =
staging (2017-09-20 20:33:48 +0100)
>>
>> are available in the git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 8acf7b48e0098198057db048340606c7fbfc651=
8:
>>
>>   chardev: remove context in chr_update_read_handler (2017-09-22 14:03=
:27 +0200)
>>
>> v2 fixes some issues with the new qemu-pr-helper.  make install and sy=
stemd
>> socket activation were broken.  I have now backported it to the Fedora=
 QEMU
>> packages to shake out any distro-level issues.
>>
>> ----------------------------------------------------------------
>> * Speed up AddressSpaceDispatch creation (Alexey)
>> * Fix kvm.c assert (David)
>> * Memory fixes and further speedup (me)
>> * Persistent reservation manager infrastructure (me)
>> * virtio-serial: add enable_backend callback (Pavel)
>> * chardev GMainContext fixes (Peter)
>=20
> In today's episode of "compiler whinges" we have
>=20
> /home/pm215/qemu/scsi/qemu-pr-helper.c: In function =E2=80=98main=E2=80=
=99:
> /home/pm215/qemu/scsi/qemu-pr-helper.c:912:5: error: comparison is
> always true due to limited range of data type [-Werror=3Dtype-limits]
>      while ((ch =3D getopt_long(argc, argv, sopt, lopt, &opt_ind)) !=3D=
 -1) {
>      ^
>=20
> (reported by the gcc on my ppc64, s390x, aarch64, aarch32 setups).
>=20
> This one's a genuine bug, I think: ch is a char, which is unsigned on
> these systems, and so the loop would never terminate.

Yes, it is a bug.  I copied the line from qemu-nbd, but qemu-nbd has
"int ch".

Paolo
