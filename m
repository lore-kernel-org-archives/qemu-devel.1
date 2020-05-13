Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA22CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660D220661
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=argosnet.com header.i=@argosnet.com header.b="K13lxtxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660D220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=argosnet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYnTd-00037Q-J1
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 05:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYnSZ-0001j9-F0; Wed, 13 May 2020 05:13:51 -0400
Received: from mx.argosnet.com ([51.255.124.196]:39867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYnSX-0003J3-JV; Wed, 13 May 2020 05:13:50 -0400
Received: from mx.argosnet.com (Argosnet [51.255.124.196])
 by mx.argosnet.com (Postfix) with ESMTP id EC18E482BD;
 Wed, 13 May 2020 11:13:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=argosnet.com; h=date:to
 :from:subject:cc:in-reply-to:references:mime-version
 :content-type:content-transfer-encoding; s=mx; bh=VrfQ2wwA/bRc8t
 m7nfSWkX542vM=; b=K13lxtxLG6V9Lrm5oxBlqafh8E5L8NMk1u2HWg2h3anodZ
 jFAugHEmnW0z5RUMmSImibtg6a5iFIs30llSf4kaKzoa05yCF917wjRjD9dQx3se
 9kjoZYTT6iJl9yeSQgFomH100Z94wCWVtOVEw09gpvid8bg9xzd8E318uhD+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=argosnet.com; h=date:to:from
 :subject:cc:in-reply-to:references:mime-version:content-type
 :content-transfer-encoding; q=dns; s=mx; b=BXZuQEZZSF3nmtIZZgMg5
 nuRaq2bzYLUr8wjG38Ooc50SMQENruKEP73F6gNpkpUij+gKMQAEgnzufZ4EGJAI
 RbFJCAJcq+9+AdKLo/o1p/fr2Mz85+PiO1r/aKv6A5XvX8ay2oVt0/CdqSVZ9ywG
 Chrh4oH5KwYkpg6smhyqGw=
Received: from Osgiliath.argosnet.com
 (lfbn-nic-1-419-246.w90-116.abo.wanadoo.fr [90.116.244.246])
 (Authenticated sender: llevier@pop.argosnet.com)
 by mx.argosnet.com (Postfix) with ESMTPSA id C3247482BC;
 Wed, 13 May 2020 11:13:43 +0200 (CEST)
X-Mailer: QUALCOMM Windows Eudora Version 7.1.0.9
Date: Wed, 13 May 2020 11:13:45 +0200
To: Daniel P. =?iso-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
From: B3r3n <B3r3n@argosnet.com>
Subject: Re: Qemu, VNC and non-US keymaps
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=C3=83?= ? ? 
 =?iso-8859-1?Q?=C3=83?= ? =?iso-8859-1?Q?=C3=82=C2=A9?=
 <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-discuss@nongnu.org
In-Reply-To: <20200513084257.GC1215285@redhat.com>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
 <20200511151155.GO1135885@redhat.com>
 <20200511152957.6CFA8D1826@zmta04.collab.prod.int.phx2.redhat.com>
 <20200511171930.GS1135885@redhat.com>
 <20200512074530.8729D1892D3@zmta01.collab.prod.int.phx2.redhat.com>
 <20200512091106.GH1191162@redhat.com>
 <E1jYmun-0003jN-Jq@lists.gnu.org>
 <20200513084257.GC1215285@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.255.124.196; envelope-from=B3r3n@argosnet.com;
 helo=mx.argosnet.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:38:53
X-ACL-Warn: Detected OS   = FreeBSD  [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_EUDORA=0.001, MISSING_MID=0.497, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
Message-Id: <E1jYnSZ-0001j9-F0@lists.gnu.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Daniel,

I guess it is time for me to commit=20
suicide...when you dont think about the basics : software version :-(

Was 1.0.4, moved to 1.1.0, no issue

DONT BECOME OLD ! :-)

thanks!

At 10:42 13/05/2020, Daniel P. Berrang=C3=A9 wrote:
>On Wed, May 13, 2020 at 10:38:52AM +0200, B3r3n wrote:
> > Hello Daniel,
> >
> > Ok, TigerVNC, added -shared=3D1 to behave the=20
> same as TightVNC, works greatly,
> > Thanks !
> >
> > But funny thing, I saw you were part of exchanges on that topic, noVNC
> > totally fails now.
> > Despite my keyboard isnt changed, debian VM is just in QWERTY as if=
 noVNC
> > only send keysyms.
> >
> > If you know how to force noVNC keycodes=20
> instead, digging to find the trick :-(
>
>Looking at the current git master code AFAICT it should "just work"
>unless you have an older version of it perhaps
>
>
>Regards,
>Daniel
>--
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


