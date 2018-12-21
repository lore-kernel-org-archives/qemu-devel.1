Received: from eggs.gnu.org ([2001:4830:134:3::10]:40521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gaRM2-00032Y-2Q
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gaRLx-0000QU-5I
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:25:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gaR4I-0004vC-5E
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:06:46 -0500
References: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
	<1544049446-6359-2-git-send-email-liam.merwick@oracle.com>
	<20181211140124.GA23460@stefanha-x1.localdomain>
	<83b577e6-691e-08b3-e9e4-90651e988ff2@oracle.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <a577be2e-8753-93ab-3034-a6288733e32f@oracle.com>
Date: Fri, 21 Dec 2018 20:03:33 +0000
MIME-Version: 1.0
In-Reply-To: <83b577e6-691e-08b3-e9e4-90651e988ff2@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/3] pvh: Add x86/HVM direct boot ABI header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, Maran Wilson <maran.wilson@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, George Kennedy <george.kennedy@oracle.com>, liam.merwick@oracle.com

On 11/12/2018 14:57, Liam Merwick wrote:
> On 11/12/2018 14:01, Stefan Hajnoczi wrote:
>> On Wed, Dec 05, 2018 at 10:37:24PM +0000, Liam Merwick wrote:
>>> From: Liam Merwick <Liam.Merwick@oracle.com>
>>>
>>> The x86/HVM direct boot ABI permits Qemu to be able to boot directly
>>> into the uncompressed Linux kernel binary without the need to run=20
>>> firmware.
>>>
>>> =A0=A0=A0=A0https://xenbits.xen.org/docs/unstable/misc/pvh.html
>>>
>>> This commit adds the header file that defines the start_info struct
>>> that needs to be populated in order to use this ABI.
>>>
>>> Signed-off-by: Maran Wilson <Maran.Wilson@oracle.com>
>>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>>> Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
>>> ---
>>> =A0 include/hw/xen/start_info.h | 146=20
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>> =A0 1 file changed, 146 insertions(+)
>>> =A0 create mode 100644 include/hw/xen/start_info.h
>>
>> Does it make sense to bring in Linux
>> include/xen/interface/hvm/start_info.h via QEMU's
>> include/standard-headers/?
>>
>> QEMU has a script in scripts/update-linux-header.sh for syncing Linux
>> headers into include/standard-headers/.=A0 This makes it easy to keep
>> Linux header files up-to-date.=A0 We basically treat files in
>> include/standard-headers/ as auto-generated.
>>
>> If you define start_info.h yourself without using
>> include/standard-headers/, then it won't be synced with Linux.
>>
>=20
> That does seem better.=A0 I will make that change.

When attempting to implement this, I found the canonical copy of this=20
header file is actually in Xen and the Linux copy is kept in sync with=20
that.  Also, 'make headers_install' doesn't install those Xen headers.

Instead I updated the commit comment to mention the canonical copy=20
location.  This file isn't expected to change much so I think keeping it=20
in sync in future shouldn't be onerous.

Regards,
Liam
