Received: from eggs.gnu.org ([2001:4830:134:3::10]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD4YT-0004OD-Ul
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD4YP-00006M-0O
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:20:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eD4YO-0008WQ-Qd
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:20:44 -0500
References: <1510299947-11287-1-git-send-email-wanpeng.li@hotmail.com>
	<CANRm+Cw_Sg04WV0J4tMXy6CSPa+GqfH31hch8p0XCZKmxT=VLQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba16ac41-c123-e34a-3584-35dd062ff30d@redhat.com>
Date: Fri, 10 Nov 2017 09:20:36 +0100
MIME-Version: 1.0
In-Reply-To: <CANRm+Cw_Sg04WV0J4tMXy6CSPa+GqfH31hch8p0XCZKmxT=VLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_TLB_FLUSH CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 10/11/2017 08:54, Wanpeng Li wrote:
> 2017-11-10 15:45 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
>> From: Wanpeng Li <wanpeng.li@hotmail.com>
>>
>> Adds PV_TLB_FLUSH CPUID feature bit.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>> ---
>>  target/i386/cpu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 6f21a5e..ecebc5a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -347,7 +347,7 @@ static FeatureWordInfo feature_word_info[FEATURE_W=
ORDS] =3D {
>>          .feat_names =3D {
>>              "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
>>              "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-un=
halt",
>> -            NULL, NULL, NULL, NULL,
>> +            NULL, "kvm-pv-tlb-flush", NULL, NULL,
>=20
> Note: bit 8 is reserved for the PV_DEDICATED which is posted by
> another guy in kvm community.
>=20
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, NULL, NULL,
>> --
>> 2.7.4
>>

I'd like PV_DEDICATED to be bit 0 in another feature word (it's a
performance hint, not a feature), but it's okay to use bit 9.

Paolo
