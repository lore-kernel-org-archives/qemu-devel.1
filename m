Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801EC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50F52086A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50F52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ8go-0002O4-34
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:00:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ8g5-000247-QH
	for qemu-devel@nongnu.org; Mon, 13 May 2019 06:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ8g4-0003ar-VD
	for qemu-devel@nongnu.org; Mon, 13 May 2019 06:59:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hQ8g4-0003ZU-L4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 06:59:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MC2o9-1hXaP01SW5-00CPPd; Mon, 13 May 2019 12:59:23 +0200
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmlfzaoh9p.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <22a102cc-c087-bd8f-a114-0b240c3fe5eb@vivier.eu>
Date: Mon, 13 May 2019 12:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <mvmlfzaoh9p.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pQQBRNSK7PsfMYBW+sYjhtbRt/9Y9HsqfMJVgk0UzD3F67iwX0A
	FayayfyBxdsPsVzwAOMxICgHR/ANtbgZeXnGle6eLYDCBCrK1eTpldEp2jkSQHiou9eLUxb
	45XTpSXY5vYugrohSwtiO4yl1J+J304COEqzeGj3ea+29URIOKYFPGRa1hZqMjPY7VjIifQ
	TJfe3KWeV3Ic38UXigRrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJ0aJeHrtHE=:ntJlncjiwtqSvfBYnDlHRU
	qKSoqq1sOsCOMAfA4u8x4MWyv1hFsh27Gj62s3dP193S+wW99Marq72C0Waog1ev5O93WCprR
	ge/tesaFgR2nY9J7+S6rtirL+KURBfu+0rkr86Ui9gDS5koYugWy0PzKp/Nw+z2C790kt9fXO
	9A64qEot2IJ42N+q9Pj0QOCDC/r36/187zyV7z1lTahkFrbhRdDZfYHA3O4k18k+LJuKY12Zm
	9Ba+YO5mpkVV5ZJVJB1gJ1XYe8iB11djUqzFr1Y8L5Ta121UdFSVx9QoFUfCG0JHLYFwHGkT+
	m7a7mreKG/Y5/Wi0HaVZWj4wGZq54ZAMnaR1+byExiRj4C38k5o0W0de+M7C7jXeo9zftIoFj
	cAaCjmzQS2w+JYPjIV4mmYZd0rPHKtJuFxf1Z6ANt245oKYaIj1E5uwmy+30Jc6YxeMrx13Lt
	ZiJgyquAiWCYod0QCnZEy/TPVxF51R6n8nbMbe2OFRQuxJMjeQbRFZHHMB5mKr3F1ccDGGULW
	stYenNZoV2MBFsY6a3h5JHhEG/kS7HsqXDzTrYx3pdR28nIOtZedhuxp2lNfOWBOU16YngAIx
	Aw71czTFxELTvdbbra7e76VCxvp6QZ3bNmjaNANEKYSKOROzNp4r/7MaAThXlbNERik3HTpxy
	NlUbx7GX4H8KAL8z96eYVTlZNl75fMLzyuc+LbnlfFsDO2DIiJZ5LpCNqL/OqRfPiMYi9PigJ
	4462LSTP2gBuFJEbDcJesaJBrqklNC0f21vnJzrZFG83bZ18bDXOckh5EyM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement getsockopt
 SO_RCVTIMEO and SO_SNDTIMEO
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/2019 11:06, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



