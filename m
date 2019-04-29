Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB3C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48A3205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48A3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7wf-0008MX-UK
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:11:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7va-0007hp-Bn
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL7vZ-0000eg-4k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:10:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL7vY-0000dj-TN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:10:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so1343254wmk.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9xgOCTwgb4pUmtyzgSfV7ZgWcyAo4csDsw/PUMa3BmY=;
	b=hxt2pKFSW6s3H34c2k1y9aHuf6SsmF6eFs3n0Zx5gCKObrjpnPujotg6N0NDEKw18S
	IG5QQFfY7Aeyp1FXuXpVgUtmIZAfLfUpqi3d0VBLbe1CU3+j8JDU3GrFYT30SViEQOzG
	RIJ4bcaTYjOjrgPfWI6rGLI94ZttbMmtQiK4GVnzIMc1v+QzUzuoztqYuatIQxrxGyUb
	D/pM9fMZCfX/+pYtEUrZo4lSqrzx7QOMRHd8Y+zpdEFkDGTj0YipzHTXI+AFtCW7vg42
	N8XiVQCE5R8XzcOkQki6FiWFlwIp9MzLHCyoaDTwx6C9JqijaB4/DhDCutbFWNpSW1WY
	accw==
X-Gm-Message-State: APjAAAXMtlfu98hrbEAvMLA+g0LW2uInzjiwxWWkQS0ugTH2QiENuCYK
	1PQ/3PyeV5hByhpR+0MNaFbwzw==
X-Google-Smtp-Source: APXvYqzMbab5INIbdiXYlkf0NjlHai2feJxtqMm3JK56A3F2OfvERMXIHO5W6oizJYMqV3LYGWIEPg==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr2912768wmc.81.1556550643693; 
	Mon, 29 Apr 2019 08:10:43 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	q11sm9690773wrw.66.2019.04.29.08.10.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:10:43 -0700 (PDT)
To: qemu-devel@nongnu.org, no-reply@patchew.org, longpeng2@huawei.com
References: <155655030568.10667.13700938703853199260@c2072b67cc0c>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <223a0019-d3c6-45de-1926-a84f5b595a9f@redhat.com>
Date: Mon, 29 Apr 2019 17:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155655030568.10667.13700938703853199260@c2072b67cc0c>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
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
Cc: fam@euphon.net, patchew-devel@redhat.com, arei.gonglei@huawei.com,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429151042.scxC10rWYcHngslCVOqDgR31zB9Aw6dQslhjk-YJBrs@z>

Hi Paolo, Fam.

On 4/29/19 5:05 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1556523569-44480-1-git-send-email-longpeng2@huawei.com/
[...]
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
[...]
> The full log is available at
> http://patchew.org/logs/1556523569-44480-1-git-send-email-longpeng2@huawei.com/testing.docker-mingw@fedora/?type=message.

Weird patchew error:

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
From https://github.com/patchew-project/qemu
 - [tag update]
patchew/1554321185-2825-1-git-send-email-sandra@codesourcery.com ->
patchew/1554321185-2825-1-git-send-email-sandra@codesourcery.com
 * [new tag]
patchew/1556523569-44480-1-git-send-email-longpeng2@huawei.com ->
patchew/1556523569-44480-1-git-send-email-longpeng2@huawei.com
[...]
error: rev-list died of signal 9
fatal: remote did not send all necessary objects
fatal: The remote end hung up unexpectedly

Traceback (most recent call last):
  File "patchew-tester/src/patchew-cli", line 521, in test_one
    git_clone_repo(clone, r["repo"], r["head"], logf, True)
  File "patchew-tester/src/patchew-cli", line 53, in git_clone_repo
    subprocess.check_call(clone_cmd, stderr=logf, stdout=logf)
  File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
    raise CalledProcessError(retcode, cmd)


