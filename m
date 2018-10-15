Received: from eggs.gnu.org ([2001:4830:134:3::10]:60397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gC7KC-0004vc-Qv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gC7K8-0006ul-IY
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:10:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1gC7K8-0006s3-AT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:10:36 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <EFF8C049-EE78-4035-A38E-6A91EA219878@oracle.com>
Date: Mon, 15 Oct 2018 21:10:20 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <80DAB33E-A982-4903-AEBA-F71AB2E8AFC3@oracle.com>
References: <20180916124631.39016-1-liran.alon@oracle.com>
	<EFF8C049-EE78-4035-A38E-6A91EA219878@oracle.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, jmattson@google.com

Another gentle ping on v2 of this series?
Patch was submitted a month ago.

Thanks,
-Liran

> On 8 Oct 2018, at 20:21, Liran Alon <liran.alon@oracle.com> wrote:
>=20
> Gentle ping on v2 of this series.
> (I noticed 1st patch of series was already applied)
>=20
> Thanks,
> -Liran
>=20
>> On 16 Sep 2018, at 15:46, Liran Alon <liran.alon@oracle.com> wrote:
>>=20
>> Hi,
>>=20
>> This series aims to add support for QEMU to be able to migrate VMs =
that
>> are running nested hypervisors. In order to do so, it utilizes the =
new
>> IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
>> KVM_CAP_NESTED_STATE") which were created for this purpose.
>>=20
>> 1st patch is not really related to the goal of the patch series. It =
just
>> makes CPUX86State->xsave_buf to be compiled only when needed (When
>> compiling with KVM or HVF CPU accelerator).
>>=20
>> 2nd patch adds the support to migrate VMs that are running nested
>> hypervisors.
>>=20
>> Regards,
>> -Liran
>>=20
>> v1->v2 Changes:
>> * Renamed kvm_nested_state_length() to kvm_max_nested_state_length()
>> to better indicate it represents the max nested state size that can
>> be returned from kernel.
>> * Added error_report() calls to nested_state_post_load() to make
>> failures in migration easier to diagnose.
>> * Fixed support of migrating with various nested_state buffer sizes.
>> The following scenarios were tested:
>> (a) src and dest have same nested state size.
>> 	=3D=3D> Migration succeeds.
>> (b) src don't have nested state while dest do.
>> 	=3D=3D> Migration succeed and src don't send it's nested state.
>> (c) src have nested state while dest don't.
>> 	=3D=3D> Migration fails as it cannot restore nested state.
>> (d) dest have bigger max nested state size than src
>> 	=3D=3D> Migration succeeds.
>> (e) dest have smaller max nested state size than src but enough to =
store it's saved nested state
>> 	=3D=3D> Migration succeeds
>> (f) dest have smaller max nested state size than src but not enough =
to store it's saved nested state
>> 	=3D=3D> Migration fails
>>=20
>=20
