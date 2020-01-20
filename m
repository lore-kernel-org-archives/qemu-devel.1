Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A07C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0472073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtvibhRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0472073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQIN-0001a2-Rw
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itQFU-0006Tv-W3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 01:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itQFT-0004GA-Qt
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 01:09:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itQFT-0004Fh-NU
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 01:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579500558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hI3bHAVRvccbwowyfhpbJL2ujXNDVH/uHbvVrMOK+lU=;
 b=BtvibhRbjv8Yfkjq8x55RylWqvbuwehHsGFNO4n2/kWutiN4J7OXHZ53rQKXtz+JD0Nl4x
 fElY3ZmLGgSH7OeI2e5qm1bYh2MwdZf85/of7cRFDcLPmU/a+1L8fbMu8rU524jrwkof/x
 y+8HX1BrECemDh5XzjCRyL4OedFgDJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-5T30YNb2OSKtZtBsx7m6Cg-1; Mon, 20 Jan 2020 01:09:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF8010054E3;
 Mon, 20 Jan 2020 06:09:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 010B660BF7;
 Mon, 20 Jan 2020 06:09:08 +0000 (UTC)
Subject: Re: [PATCH v3] ui: Print available display backends with '-display
 help'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200108144702.29969-1-thuth@redhat.com>
 <b1581c7e-bc9e-3a79-a913-be48f6f550c7@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <eeb75f75-e9a3-e430-6066-eab060bc1364@redhat.com>
Date: Mon, 20 Jan 2020 07:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b1581c7e-bc9e-3a79-a913-be48f6f550c7@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5T30YNb2OSKtZtBsx7m6Cg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/2020 01.01, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 1/8/20 3:47 PM, Thomas Huth wrote:
>> We already print availabled devices with "-device help", or available
>> backends with "-netdev help" or "-chardev help". Let's provide a way
>> for the users to query the available display backends, too.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v3: Mention -display help in the qemu-doc, too (as suggested by Philipp=
e)
>>
>>  include/ui/console.h |  1 +
>>  qemu-options.hx      |  3 ++-
>>  ui/console.c         | 15 +++++++++++++++
>>  vl.c                 |  5 +++++
>>  4 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/ui/console.h b/include/ui/console.h
>> index 281f9c145b..f35b4fc082 100644
>> --- a/include/ui/console.h
>> +++ b/include/ui/console.h
>> @@ -442,6 +442,7 @@ void qemu_display_register(QemuDisplay *ui);
>>  bool qemu_display_find_default(DisplayOptions *opts);
>>  void qemu_display_early_init(DisplayOptions *opts);
>>  void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>> +void qemu_display_help(void);
>> =20
>>  /* vnc.c */
>>  void vnc_display_init(const char *id, Error **errp);
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index e9d6231438..d593931664 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1586,7 +1586,8 @@ STEXI
>>  @item -display @var{type}
>>  @findex -display
>>  Select type of display to use. This option is a replacement for the
>> -old style -sdl/-curses/... options. Valid values for @var{type} are
>> +old style -sdl/-curses/... options. Use @code{-display help} to list
>> +the available display types. Valid values for @var{type} are
>>  @table @option
>>  @item sdl
>>  Display video output via SDL (usually in a separate graphics
>> diff --git a/ui/console.c b/ui/console.c
>> index ac79d679f5..69339b028b 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -2333,6 +2333,21 @@ void qemu_display_init(DisplayState *ds, DisplayO=
ptions *opts)
>>      dpys[opts->type]->init(ds, opts);
>>  }
>> =20
>> +void qemu_display_help(void)
>> +{
>> +    int idx;
>> +
>> +    printf("Available display backend types:\n");
>> +    for (idx =3D DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
>> +        if (!dpys[idx]) {
>> +            ui_module_load_one(DisplayType_str(idx));
>> +        }
>> +        if (dpys[idx]) {
>> +            printf("%s\n",  DisplayType_str(dpys[idx]->type));
>=20
> While listed in the man page, the "none" display is not listed here, any
> clue?

I assume we'd need to print it out manually here since there is no
implementation for this in the dpys array. Care to send a patch?

 Thomas


