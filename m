Received: from eggs.gnu.org ([209.51.188.92]:51870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjTvB-0006eS-D8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjTv9-0007Sd-KT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:58:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjTv9-0007Ku-9q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:58:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so4386654wml.3
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:58:25 -0800 (PST)
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39b781be-1ac8-147f-c354-c902e1379854@redhat.com>
Date: Tue, 15 Jan 2019 19:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2Dw2F3ks_5f8cvWjrsOTS0_Ybr5kELUpyHQmOQWUaeuFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>

On 1/15/19 7:51 PM, Ed Maste wrote:
> On Tue, 15 Jan 2019 at 13:42, Ed Maste <emaste@freebsd.org> wrote:
>>
>> From: Ed Maste <emaste@freebsd.org>
> 
> I'm not sure what part of the path between `git send-email` and the
> list moved this From: into the message body, but it's not intentional.
> If someone's going to pick up this patch please edit the commit
> message.

I think this is 'git send-email' default behavior when your mail config
FROM (here emaste@freefall.freebsd.org) is different from the commit
FROM (emaste@freebsd.org), so if this patch is applied the author email
is enforced to the commit FROM.

> 
>> Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
>> several platforms, including FreeBSD.  Later on we could build for other
> ...
> 
