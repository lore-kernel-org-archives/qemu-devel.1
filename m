Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5328E206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lJ2xnzKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5328E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZnPI-0000Jg-HL
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 23:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZnOd-0008Ex-Dz
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:21:55 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:54556)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jZnOb-0008HS-O3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=VRmKV
 8WJmmAc712l5DoTyC4ZIgJc5Gt8KCtZe0USIyE=; b=lJ2xnzKdMr7o9CEfjlWDx
 IVTDIuwvXAgXIzmsjDzUXEVoAqZfnTJpq82KOcH/mPPlPOlY2EdISS8wlfnpmYLX
 L6QuWanGhAPp8bPaUPzjBalvCBxk6qGpFyYy4kmF2tpZwt89omSPhBd4Q3kFiIVB
 8Xs1noZ55xsc3irVYNhgVU=
Received: from [192.168.0.123] (unknown [114.240.93.195])
 by smtp5 (Coremail) with SMTP id HdxpCgBHeUowXL9eoNi9AA--.158S2;
 Sat, 16 May 2020 11:21:25 +0800 (CST)
Subject: Re: [PATCH v6 3/3] qemu-options: updates for abstract unix sockets
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: berrange@redhat.com
References: <20200516031327.15305-1-zxq_yx_007@163.com>
 <20200516031327.15305-4-zxq_yx_007@163.com>
Message-ID: <74e75cd3-87a2-ef81-70a1-ccced458f2f4@163.com>
Date: Sat, 16 May 2020 11:21:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200516031327.15305-4-zxq_yx_007@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: HdxpCgBHeUowXL9eoNi9AA--.158S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWDXrW7Aw47JF13tr17Awb_yoW8ZFWkpr
 95K3W3t348J3WFvrsrJa4Dtr4Fkw1kXFWxG3yru3WkKa9rW390qa4UKw15X34UArs3XryS
 vFyYyryjvF15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b0ManUUUUU=
X-Originating-IP: [114.240.93.195]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqBUmxlc7PN7eGAAAsV
Received-SPF: pass client-ip=123.126.97.5; envelope-from=zxq_yx_007@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 23:02:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2020/5/16 上午11:13, xiaoqiang zhao 写道:
> add options documents changes for -chardev
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qemu-options.hx | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e2dca8a4e9..4ee7e6c772 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2938,7 +2938,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>       "         [,server][,nowait][,telnet][,websocket][,reconnect=seconds][,mux=on|off]\n"
>       "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
>       "-chardev socket,id=id,path=path[,server][,nowait][,telnet][,websocket][,reconnect=seconds]\n"
> -    "         [,mux=on|off][,logfile=PATH][,logappend=on|off] (unix)\n"
> +    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
>       "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
>       "         [,localport=localport][,ipv4][,ipv6][,mux=on|off]\n"
>       "         [,logfile=PATH][,logappend=on|off]\n"
> @@ -3105,9 +3105,13 @@ The available backends are:
>   
>           ``nodelay`` disables the Nagle algorithm.
>   
> -    ``unix options: path=path``
> +    ``unix options: path=path[,abstract=on|off][,tight=on|off]``
>           ``path`` specifies the local path of the unix socket. ``path``
>           is required.
> +	``abstract`` specifies the use of the abstract socket namespace,
> +        rather than the filesystem.  Optional, defaults to false.
> +	``tight`` sets the socket length of abstract sockets to their minimum,
> +        rather than the full sun_path length.  Optional, defaults to true.
>   
>   ``-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr][,localport=localport][,ipv4][,ipv6]``
>       Sends all traffic from the guest to a remote host over UDP.

Daniel,  is this still okay for you ?

I have already include a Reviewed-by tag by mistake  ;-(


