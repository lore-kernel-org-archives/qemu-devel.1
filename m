Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yiB-0003UU-JI
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yiA-0005fx-Pg
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:32:51 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-8-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <14efb39b-c319-cf7d-400d-bd6fd20388b7@twiddle.net>
Date: Tue, 25 Apr 2017 13:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/13] tcg/i386: implement goto_ptr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/25/2017 09:53 AM, Emilio G. Cota wrote:
>   static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>   {
> +    static const TCGTargetOpDef ri = { .args_ct_str = { "ri" } };
>       static const TCGTargetOpDef ri_r = { .args_ct_str = { "ri", "r" } };
>       static const TCGTargetOpDef re_r = { .args_ct_str = { "re", "r" } };
>       static const TCGTargetOpDef qi_r = { .args_ct_str = { "qi", "r" } };
> @@ -2324,6 +2333,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_st_i64:
>           return &re_r;
>   
> +    case INDEX_op_goto_ptr:
> +        return &ri;
> +

This is incorrect.  You only handle register inputs (i.e. just "r") in your 
implementation.  Indeed, that's also the only thing that makes sense.


r~
