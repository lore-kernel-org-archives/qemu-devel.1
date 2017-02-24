Received: from eggs.gnu.org ([2001:4830:134:3::10]:48461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chC4E-0000sS-LS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chC49-00044C-O6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:21:34 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chC49-00043q-Hf
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:21:29 -0500
Received: by mail-wm0-x234.google.com with SMTP id v186so9751887wmd.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 01:21:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-8-git-send-email-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b884a9c8-2332-acd3-64b1-5ecccc1a50dc@redhat.com>
Date: Fri, 24 Feb 2017 10:21:28 +0100
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-8-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] qxl: use graphic_* variables.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org



On 21/02/2017 23:14, Gerd Hoffmann wrote:
>  
> +    if (graphic_width && graphic_height) {
> +        /* needs linux kernel 4.12+ to work */
> +        rom->client_monitors_config.count = 1;
> +        rom->client_monitors_config.heads[0].left = 0;
> +        rom->client_monitors_config.heads[0].top = 0;
> +        rom->client_monitors_config.heads[0].right = cpu_to_le32(graphic_width);
> +        rom->client_monitors_config.heads[0].bottom = cpu_to_le32(graphic_height);
> +        rom->client_monitors_config_crc = qxl_crc32(
> +            (const uint8_t *)&rom->client_monitors_config,
> +            sizeof(rom->client_monitors_config));
> +    }
> +

Same here.

Paolo
