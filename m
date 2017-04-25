Received: from eggs.gnu.org ([2001:4830:134:3::10]:58504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yHR-0004Pj-7i
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yHQ-0004Tp-Da
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:05:13 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-7-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bb5e7db4-5e91-06cb-5902-c22309132951@twiddle.net>
Date: Tue, 25 Apr 2017 13:05:03 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/13] tcg: add goto_ptr opcode
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
> @@ -1138,6 +1138,7 @@ void tcg_dump_ops(TCGContext *s)
>               }
>               switch (c) {
>               case INDEX_op_set_label:
> +            case INDEX_op_goto_tb:
>               case INDEX_op_br:
>               case INDEX_op_brcond_i32:
>               case INDEX_op_brcond_i64:

This is wrong, and causes crashes when dumping.  Nor should goto_ptr be here, 
so I don't know what you were after.


r~
