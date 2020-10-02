Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CB120708
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CB120708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMjd-0004oY-0I
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rafaeldtinocoextra@gmail.com>)
 id 1kOMIY-0002Ra-CJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rafaeldtinocoextra@gmail.com>)
 id 1kOMIW-0004eo-O9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id q5so1573071qkc.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:cc:date:message-id:in-reply-to
 :references:reply-to:user-agent:mime-version
 :content-transfer-encoding;
 bh=/Pmjcl4A+vC2oLSf2jZDBTV0a+8ynh/nNEtRUbNYiG0=;
 b=i536VUd/uKW+zKSgLYrBHmlD4Di0et+y+nASzdNjG567kiAc+r5e4z72W7m6stw1/Q
 bvkQSJKCY0XlAp/GUelc+9OR24ANGZgphRkon3b9rGLqapTg0lHPpqKqeppSnuCqci6m
 gAKsN45VkBjQbMnmL6i/3ohoViUMmizztsfFxs5Y8Ph2Ug25gYHEngi/zouNY4joacwD
 VXaPpwA4g7zDJdO2DSRtkD+ulWNEtMIICpz3WD+/9Mur7Ibc4y05moAgEwzr8BHcjqPq
 XS5JVY0R7Kc5rLW1dFmpuedrdpec1NPEZxVtfsG5r9dntVjhWVQwaOwRuSerErY1emGE
 BBKw==
X-Gm-Message-State: AOAM533XZ3BkLpqFbsJsfDI6LoL3hv8LjuEkWvlbWWiZ4cHIT1MC+sAJ
 XMF7//gyzJW1hyu3uBPyi0M=
X-Google-Smtp-Source: ABdhPJy7nN8rnnbwy6m2rv4WJxCY1Yw//AQLhAsjAvz3/hD7C5jSloHdhoZPTrZUqVta8x34CkOUtw==
X-Received: by 2002:a05:620a:24c2:: with SMTP id
 m2mr2321185qkn.14.1601649875218; 
 Fri, 02 Oct 2020 07:44:35 -0700 (PDT)
Received: from [10.5.0.2] ([192.154.198.30])
 by smtp.gmail.com with ESMTPSA id 16sm1161657qks.102.2020.10.02.07.44.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Oct 2020 07:44:33 -0700 (PDT)
From: "Rafael David Tinoco" <rafaeldtinoco@ubuntu.com>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 =?utf-8?q?Daniel=20P=2e=20Berrang=c3=a9?= <berrange@redhat.com>
Subject: Re: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
Date: Fri, 02 Oct 2020 14:44:28 +0000
Message-Id: <em1ae41357-e633-47b8-b332-dff2e66999f6@lenovo>
In-Reply-To: <CAFEAcA-PGNqugn-deNMJv1v49GRB=8UbhXYL3Fpko9do4+rsWQ@mail.gmail.com>
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
 <20200729195829.1335082-1-ddstreet@canonical.com>
 <20200922163441.GA2049853@redhat.com>
 <CAOZ2QJPsSTH4MStgduBGjhvaH-5-Tgj7-++qYLbSmQnqWQPpug@mail.gmail.com>
 <20201002131130.GB2338114@redhat.com>
 <CAFEAcA-PGNqugn-deNMJv1v49GRB=8UbhXYL3Fpko9do4+rsWQ@mail.gmail.com>
User-Agent: eM_Client/8.0.3385.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.222.194;
 envelope-from=rafaeldtinocoextra@gmail.com; helo=mail-qk1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 10:44:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc: Dan Streetman <ddstreet@canonical.com>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>>  Assuming you're just using git for conveniently applying local
>>  downstream patches, you don't need the git repo to exist once
>>  getting to the build stage. IOW just delete the .git dir after
>>  applying patches before running a build.
>
>...then what do you do if the build fails and you want to
>edit/update the patch before retrying? "Blow away your .git
>tree every time you build and reconstitute it somehow later"
>doesn't seem like a very friendly thing to require...

+1. This option is disconnected with sustaining engineering reality=20
IMHO: tons of interactive rebases, adding and dropping patches,=20
re-orderings - so previous existing patches can allow the new ones (or=20
even existing ones) to become clean cherry-picks - in between patch sets=20
being worked on, bisections before continuing all this, etc.


