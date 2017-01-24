Received: from eggs.gnu.org ([2001:4830:134:3::10]:59696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW0ab-0001dD-Us
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW0aa-0006M7-SQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:52:46 -0500
References: <1485262161-18543-1-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e09fbf16-a5ba-ed74-791c-875d8c846203@redhat.com>
Date: Tue, 24 Jan 2017 13:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <1485262161-18543-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: statically link
 qemu_iscsi_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org



On 24/01/2017 13:49, Peter Lieven wrote:
> +#ifdef CONFIG_LIBISCSI

The #ifdef is not needed here.

Paolo

> +static QemuOptsList qemu_iscsi_opts = {
> +    .name = "iscsi",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_iscsi_opts.head),
> +    .desc = {
> +        {
> +            .name = "user",
> +            .type = QEMU_OPT_STRING,
> +            .help = "username for CHAP authentication to target",
> +        },{
> +            .name = "password",
> +            .type = QEMU_OPT_STRING,
> +            .help = "password for CHAP authentication to target",
> +        },{
> +            .name = "password-secret",
> +            .type = QEMU_OPT_STRING,
> +            .help = "ID of the secret providing password for CHAP "
> +                    "authentication to target",
> +        },{
> +            .name = "header-digest",
> +            .type = QEMU_OPT_STRING,
> +            .help = "HeaderDigest setting. "
> +                    "{CRC32C|CRC32C-NONE|NONE-CRC32C|NONE}",
> +        },{
> +            .name = "initiator-name",
> +            .type = QEMU_OPT_STRING,
> +            .help = "Initiator iqn name to use when connecting",
> +        },{
> +            .name = "timeout",
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "Request timeout in seconds (default 0 = no timeout)",
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static void iscsi_block_opts_init(void)
> +{
> +    qemu_add_opts(&qemu_iscsi_opts);
> +}
> +
> +block_init(iscsi_block_opts_init);
> +#endif
