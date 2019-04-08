Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9446C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78882147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78882147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDWJk-0003I4-VQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:36:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDWIz-0002rw-2g
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDWIy-0006hC-4F
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:35:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hDWIv-0006eC-R1; Mon, 08 Apr 2019 11:35:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7A91308302F;
	Mon,  8 Apr 2019 15:35:24 +0000 (UTC)
Received: from work-vm (ovpn-117-240.ams2.redhat.com [10.36.117.240])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2992318FCA;
	Mon,  8 Apr 2019 15:35:23 +0000 (UTC)
Date: Mon, 8 Apr 2019 16:35:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190408153520.GG2687@work-vm>
References: <20190408153003.20596-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408153003.20596-1-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 08 Apr 2019 15:35:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] hmp: Fix drive_add ... format=help crash
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
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408153520.Ik5h3hWtR06hnTyRczpanz8GaXIq5XwNxEavSlztU-I@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> drive_new() returns null without setting an error when it provided
> help.  add_init_drive() assumes null means failure, and crashes trying
> to report a null error.
> 
> Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2: Make tests/test-hmp.c cover the bug
> 
>  device-hotplug.c | 2 +-
>  tests/test-hmp.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/device-hotplug.c b/device-hotplug.c
> index 6090d5f1e9..6153259d71 100644
> --- a/device-hotplug.c
> +++ b/device-hotplug.c
> @@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
>  
>      mc = MACHINE_GET_CLASS(current_machine);
>      dinfo = drive_new(opts, mc->block_default_type, &err);
> -    if (!dinfo) {
> +    if (err) {
>          error_report_err(err);
>          qemu_opts_del(opts);
>          return NULL;
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 8c49d2fdf1..54a01824dc 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -31,6 +31,7 @@ static const char *hmp_cmds[] = {
>      "cpu 0",
>      "device_add ?",
>      "device_add usb-mouse,id=mouse1",
> +    "drive_add ignored format=help",

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      "mouse_button 7",
>      "mouse_move 10 10",
>      "mouse_button 0",
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

