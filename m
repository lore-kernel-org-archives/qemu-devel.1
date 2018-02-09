Received: from eggs.gnu.org ([2001:4830:134:3::10]:33465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek84e-0003cO-6Z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek84Z-00085e-Bd
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:46:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek84Z-00085L-78
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:46:35 -0500
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
	<20180208181207.GB13981@localhost.localdomain>
	<fcb084ce-1615-f100-4137-e0fa46098d7b@redhat.com>
	<20180209114615.GG13981@localhost.localdomain>
	<CANRm+CyJi0r-Gm=ivJDwBhsW1dM5tAhBBx84G+miOQDaF+nLUw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70c00938-9dd4-e088-d874-dc8fb5469e6c@redhat.com>
Date: Fri, 9 Feb 2018 13:46:18 +0100
MIME-Version: 1.0
In-Reply-To: <CANRm+CyJi0r-Gm=ivJDwBhsW1dM5tAhBBx84G+miOQDaF+nLUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 09/02/2018 13:24, Wanpeng Li wrote:
> The guest fails to detect the new cpuid this time.

You have to debug the KVM_SET_CPUID2 ioctls and see why it is not set.

Paolo

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d70954b..e2974ad 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -358,6 +358,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EAX,
>          .tcg_features = TCG_KVM_FEATURES,
>      },
> +    [FEAT_KVM_HINTS] = {
> +        .feat_names = {
> +            "hint-dedicated", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
> +        .tcg_features = TCG_KVM_FEATURES,
> +    },
