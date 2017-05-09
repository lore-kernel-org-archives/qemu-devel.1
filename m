Received: from eggs.gnu.org ([2001:4830:134:3::10]:40119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85m4-0002lH-4p
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85m0-0007im-70
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:06:00 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d85lz-0007ig-Te
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:05:56 -0400
Received: by mail-qt0-x236.google.com with SMTP id m91so1402784qte.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:05:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509132736.10071-1-berrange@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <040c1e25-224f-1a8a-9f60-7238e6ad5df6@twiddle.net>
Date: Tue, 9 May 2017 07:05:51 -0700
MIME-Version: 1.0
In-Reply-To: <20170509132736.10071-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Support CPUID signature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 05/09/2017 06:27 AM, Daniel P. Berrange wrote:
> This enables report of a signature in CPUID for the TCG
> interpretor.
> 
> Changed in v4:
> 
>   - Report 0x40000001 in EAX for 0x40000000 index (Eduardo)
>   - Report all zeros for 0x40000001 index (Eduardo)
>   - Make code style consistent when checking limits (Eduardo)
> 
> Changed in v3:
> 
>   - Simplify CPU limit code still further (Eduardo)
> 
> Changed in v2:
> 
>   - Rewrite the way we bounds check / cap the CPUID index
>     to use a flat switch, instead of nested ifs (Eduardo)
>   - Add a 'tcg-cpuid' property to allow it to be hidden
>     (Eduardo)
>   - Hide the TCG signature for old machine types
>   - Force code to a no-op if tcg_enabled() is false (Eduardo)
> 
> 
> NB, I did not introduce a general 'hypervisor-cpuid' property
> to obsolete the existing 'kvm=off|on' -cpu property, since it
> appears impossible to get the back compat semantics right,
> as described in a previous reply.
> 
> Daniel P. Berrange (2):
>    i386: rewrite way CPUID index is validated
>    i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf

I probably should have commented earlier but...  what's the point?

If you want the guest os to actually do anything with this, what do you gain 
for advertising TCG over KVM?


r~
