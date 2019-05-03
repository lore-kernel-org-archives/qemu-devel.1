Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C6C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768B62070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768B62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZlY-0004m6-L7
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:06:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMZkd-0004Jv-Qb
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMZkb-0001ub-Tj
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:05:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMZka-0001tT-8f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:05:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so8282746wrq.10
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fx/CEaqulF8jXdEU1EEgRgqXdt6pDvUapQcagCObCMc=;
	b=KwX5UgwLG2brn//wxEBvvqZcz0X+IS9B6mMc0ssIjq6zPFhtkdvfnmbufMstlA0jG1
	Jrgm7RUS006jz07/IqRvbULIBsmYVTtc/lYGzdOq+IARKNxQwo2G/G83BaG4bdPkoKrZ
	TnUwcae2zq4bucy2Jjv5HA5Zps56tM/HWgqqdcOKQcNvIKUNibZhhV1MHaJY1EGyREkL
	GZKdP3Fn4V5aJibOou6IhQJhHeqbyw0ct0+EeHCc28viqVFjhywHNnbMA7IFF0XNJqou
	JFv34ESmZOEE593OGSaMy5lvq+VD///bOE3aq4qKLMKwFnaljmfIEt/Qp11YY5Q6ORuo
	kUVQ==
X-Gm-Message-State: APjAAAX7Lyy+kY64U1TBaLoA0u5rSV6H+V9ZCxhnbfRRyWmeXYVNfxSd
	dNtriYJm6y9gGLxM8CzIUbvsXQ==
X-Google-Smtp-Source: APXvYqysjg8dUSCcBolOa0ppWC9wj3wUbPP8xgLlOFaAQ876eDK5S/6dGVFJKsFMwD045lNhFSv3/w==
X-Received: by 2002:adf:f051:: with SMTP id t17mr6960449wro.73.1556895923051; 
	Fri, 03 May 2019 08:05:23 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a11sm1627275wmm.35.2019.05.03.08.05.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 08:05:22 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA-eVOZhXj+OLB+VvxXZTniny_sMCFaeWsv+2uEErM-=zA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b70484a8-b408-7c2b-7fd7-27f1c1d98f4d@redhat.com>
Date: Fri, 3 May 2019 17:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-eVOZhXj+OLB+VvxXZTniny_sMCFaeWsv+2uEErM-=zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503150521.97YTg129SAHXMVqycius57nNxScBzOQ-IQGXISBVyCE@z>

On 5/3/19 2:54 PM, Peter Maydell wrote:
> On Thu, 2 May 2019 at 23:30, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
>>
>> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
>>
>>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>>
>> for you to fetch changes up to 7c57bdd82026ba03f3158bbcd841afde7c2dc43a:
>>
>>   build-sys: move slirp as git submodule project (2019-05-03 00:15:37 +0200)
>>
>> ----------------------------------------------------------------
>> slirp: move slirp as git submodule project
>>
>> Marc-André Lureau (2):
>>   build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>>   build-sys: move slirp as git submodule project
>>
>> ----------------------------------------------------------------
>> Marc-André Lureau (2):
>>       build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>>       build-sys: move slirp as git submodule project
>>
> 
> 
> Applied, thanks.

TL;DR: You might need to run 'git submodule deinit --force slirp' if ou
get errors after merging this.

--

FYI I was running MinGW tests with "make docker-test-mingw@fedora
SHOW_ENV=1 J=8 NETWORK=1" and ran "git pull" to refresh my local repo,
and got:

$ make docker-test-mingw@fedora SHOW_ENV=1 J=8 NETWORK=1
make[1]: Entering directory '/home/phil/source/qemu'
  GEN
/home/phil/source/qemu/docker-src.2019-05-03-16.55.51.7157/qemu.tar
slirp: unmerged (59a1b1f165458c2acb7ff0525b543945f7416225)
fatal: git-write-tree: error building trees
Cannot save the current index state
Cloning into
'/home/phil/source/qemu/docker-src.2019-05-03-16.55.51.7157/qemu.tar.vroot'...
done.
error: pathspec 'slirp:' did not match any file(s) known to git.
error: pathspec 'needs' did not match any file(s) known to git.
error: pathspec 'merge' did not match any file(s) known to git.
failed to checkout slirp: needs merge revision
tar: /var/tmp/qemu/qemu.tar: Cannot open: No such file or directory
tar: Error is not recoverable: exiting now
Failed to untar source
tests/docker/Makefile.include:203: recipe for target 'docker-run' failed
make[1]: *** [docker-run] Error 1

I don't run builds on this host (no tools installed) but everything via
Docker, so (re-)running ./configure is not an option.

$ git status
Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

        added by us:     slirp

$ ls -la slirp/
total 8
drwxr-xr-x  2 phil phil 4096 May  3 16:49 .
drwxr-xr-x 56 phil phil 4096 May  3 16:55 ..

$ git submodule status slirp
U0000000000000000000000000000000000000000 slirp

Daniel suggested on IRC to run:

$ git submodule deinit --force slirp

It worked fine after running it.

Regards,

Phil.

