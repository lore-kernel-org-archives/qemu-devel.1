Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CB2C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DAB22204
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4RztemT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DAB22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcoh-0004av-SK
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFclz-0007n1-5d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:30:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFclx-000871-4X
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599568252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diIacTlQYTokGdQ2+Tvjn/UdRwZ0NuHMsPby1L6K7X4=;
 b=B4RztemThwEyu+PEC94500rtBHZ9ctS5tMdpCa9rBb5pQTJnEguMpz+lEhD3B+4341p9xZ
 LYh0ZH+qWmGaHUKUvn62aB227ZdKVDKSHZGQgh4Zx4hkYKO/P63ZXOPzSeEZU937xmtLBG
 3spcrO4eB55lOv2e30XqNjrxqvxxhh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-DMB6IdyxPbmdHz2gp6OBCg-1; Tue, 08 Sep 2020 08:30:50 -0400
X-MC-Unique: DMB6IdyxPbmdHz2gp6OBCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A28E4E75C;
 Tue,  8 Sep 2020 12:30:49 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DF2782460;
 Tue,  8 Sep 2020 12:30:45 +0000 (UTC)
Subject: Re: [PATCH v2] scripts/git.orderfile: Display meson files along with
 buildsys ones
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200907161222.41915-1-philmd@redhat.com>
 <bd658d44-d9bd-81d1-f3c7-89c0d61f6dd2@redhat.com>
 <79de1ef4-6e08-6f1c-030e-f40e7410e06c@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2d435bb0-eb8d-7a12-b962-2bce246c30fb@redhat.com>
Date: Tue, 8 Sep 2020 14:30:44 +0200
MIME-Version: 1.0
In-Reply-To: <79de1ef4-6e08-6f1c-030e-f40e7410e06c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/08/20 13:48, Paolo Bonzini wrote:
> On 08/09/20 12:02, Laszlo Ersek wrote:
>> Possibly related (not sure if there's another patch pending for it
>> already): if you run a "make clean" in the source tree, and have the
>> Meson submodule initialized, the "make clean" will delete files from the
>> Meson submodule.
>>
>> find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
>>
>> "*.d" matches various meson files.
>>
>> (Again, apologies if this is already known; I understand this is
>> probably the worst context to report his in...)
>
> Is this running "make clean" from an old commit (i.e. as in an in-tree
> build) after having checked out the meson submodule?

The source tree is checked out at commit 9d5589bb3fee ("Merge
remote-tracking branch
'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging",
2020-09-07).

The current working directory is the source tree.

The working directory is pristine, as in:
$ git reset --hard
$ git clean -ffdx
$ git submodule deinit --force --all

Then:

$ git submodule update --init --force
$ make clean
$ git status

> On branch master
> Your branch is up to date with 'origin/master'.
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working > directory)
>   (commit or discard the untracked or modified content in submodules)
>
>         modified:   meson (modified content)
>
> no changes added to commit (use "git add" and/or "git commit -a")

And if I change to meson:

$ cd meson
$ git status

> HEAD detached at 68ed748f84f1
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>         deleted:    test cases/d/1 simple/app.d
>         deleted:    test cases/d/1 simple/utils.d
>         deleted:    test cases/d/10 d cpp/dmain.d
>         deleted:    test cases/d/10 d cpp/libfile.d
>         deleted:    test cases/d/11 dub/test.d
>         deleted:    test cases/d/2 static library/app.d
>         deleted:    test cases/d/2 static library/libstuff.d
>         deleted:    test cases/d/3 shared library/app.d
>         deleted:    test cases/d/3 shared library/libstuff.d
>         deleted:    test cases/d/3 shared library/sub/libstuff.d
>         deleted:    test cases/d/4 library versions/lib.d
>         deleted:    test cases/d/5 mixed/app.d
>         deleted:    test cases/d/6 unittest/app.d
>         deleted:    test cases/d/6 unittest/second_unit.d
>         deleted:    test cases/d/7 multilib/app.d
>         deleted:    test cases/d/7 multilib/say1.d
>         deleted:    test cases/d/7 multilib/say2.d
>         deleted:    test cases/d/9 features/app.d
>         deleted:    test cases/d/9 features/extra.d
>
> no changes added to commit (use "git add" and/or "git commit -a")

I don't know if the "clean" target has any relevance left, in the
top-level Makefile; I've only looked at it now because the command

> 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
> 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
> 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
> 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
> 		-exec rm {} +

needed an update (removing the sqlite3.dll exception) for the
edk2-stable202008 update.

Thanks!
Laszlo


