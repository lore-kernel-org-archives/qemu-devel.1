Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B51C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F01217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F01217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAryx-0000H5-Fq
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvT-0004nu-U0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvS-000091-TL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvS-00008p-OL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 193BF3C919;
 Thu, 19 Sep 2019 08:36:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D073860C18;
 Thu, 19 Sep 2019 08:36:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 14D211747D; Thu, 19 Sep 2019 10:36:26 +0200 (CEST)
Date: Thu, 19 Sep 2019 10:36:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190919083626.qjilasttfb5pv5ao@sirius.home.kraxel.org>
References: <20190918095335.7646-1-stefanha@redhat.com>
 <20190918095335.7646-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918095335.7646-3-stefanha@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 19 Sep 2019 08:36:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] audio: add -audiodev pa,
 in|out.latency= to documentation
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
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 10:53:34AM +0100, Stefan Hajnoczi wrote:
> The "latency" parameter wasn't covered by the documentation.

Doesn't apply cleanly (on top of the surround sound patch series).
Picked the other two into the pull request.
Please rebase & resend once this is merged.

thanks,
  Gerd

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-options.hx | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index a4f9f74f52..6d7fe57dd4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -470,6 +470,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>      "-audiodev pa,id=id[,prop[=value][,...]]\n"
>      "                server= PulseAudio server address\n"
>      "                in|out.name= source/sink device name\n"
> +    "                in|out.latency= desired latency in microseconds\n"
>  #endif
>  #ifdef CONFIG_AUDIO_SDL
>      "-audiodev sdl,id=id[,prop[=value][,...]]\n"
> @@ -630,6 +631,10 @@ Sets the PulseAudio @var{server} to connect to.
>  @item in|out.name=@var{sink}
>  Use the specified source/sink for recording/playback.
>  
> +@item in|out.latency=@var{usecs}
> +Desired latency in microseconds.  The PulseAudio server will try to honor this
> +value but actual latencies may be lower or higher.
> +
>  @end table
>  
>  @item -audiodev sdl,id=@var{id}[,@var{prop}[=@var{value}][,...]]
> -- 
> 2.21.0
> 

