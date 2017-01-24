Received: from eggs.gnu.org ([2001:4830:134:3::10]:59881)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cW0bJ-0002FR-PY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cW0bF-0006mO-UT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:53:29 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:59344 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cW0bF-0006kM-M1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:53:25 -0500
References: <1485262161-18543-1-git-send-email-pl@kamp.de>
	<e09fbf16-a5ba-ed74-791c-875d8c846203@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <f803154c-3197-6bf7-cca4-023c20facc95@kamp.de>
Date: Tue, 24 Jan 2017 13:53:23 +0100
MIME-Version: 1.0
In-Reply-To: <e09fbf16-a5ba-ed74-791c-875d8c846203@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org

Am 24.01.2017 um 13:52 schrieb Paolo Bonzini:
>
> On 24/01/2017 13:49, Peter Lieven wrote:
>> +#ifdef CONFIG_LIBISCSI
> The #ifdef is not needed here.

Right, can you drop it or shall I send a V2?

Peter

>
> Paolo
>
>> +static QemuOptsList qemu_iscsi_opts = {
>> +    .name = "iscsi",
>> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_iscsi_opts.head),
>> +    .desc = {
>> +        {
>> +            .name = "user",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "username for CHAP authentication to target",
>> +        },{
>> +            .name = "password",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "password for CHAP authentication to target",
>> +        },{
>> +            .name = "password-secret",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "ID of the secret providing password for CHAP "
>> +                    "authentication to target",
>> +        },{
>> +            .name = "header-digest",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "HeaderDigest setting. "
>> +                    "{CRC32C|CRC32C-NONE|NONE-CRC32C|NONE}",
>> +        },{
>> +            .name = "initiator-name",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "Initiator iqn name to use when connecting",
>> +        },{
>> +            .name = "timeout",
>> +            .type = QEMU_OPT_NUMBER,
>> +            .help = "Request timeout in seconds (default 0 = no timeout)",
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +static void iscsi_block_opts_init(void)
>> +{
>> +    qemu_add_opts(&qemu_iscsi_opts);
>> +}
>> +
>> +block_init(iscsi_block_opts_init);
>> +#endif


-- 

Mit freundlichen Grüßen

Peter Lieven

...........................................................

   KAMP Netzwerkdienste GmbH
   Vestische Str. 89-91 | 46117 Oberhausen
   Tel: +49 (0) 208.89 402-50 | Fax: +49 (0) 208.89 402-40
   pl@kamp.de | http://www.kamp.de

   Geschäftsführer: Heiner Lante | Michael Lante
   Amtsgericht Duisburg | HRB Nr. 12154
   USt-Id-Nr.: DE 120607556

...........................................................
