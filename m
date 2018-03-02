Received: from eggs.gnu.org ([2001:4830:134:3::10]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1erlXD-0004LM-1s
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1erlX7-0004Nh-AM
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:19:43 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1erlX7-0004Mh-54
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:19:37 -0500
Received: by mail-ua0-f196.google.com with SMTP id d1so5200260ual.13
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 06:19:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302134917.25526-1-eblake@redhat.com>
References: <20180302134917.25526-1-eblake@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Mar 2018 22:18:56 +0800
Message-ID: <CAK1Eb9mzBZ3E169dyVdumvof_=V4D6-LEnAuZmpYgqY=d5ppog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] iotests: Mark all tests executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, Mar 2, 2018 at 9:49 PM, Eric Blake <eblake@redhat.com> wrote:
> The majority of our iotests have the executable bit set; fix the
> few outliers for consistency.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> Let's see if patchew groks this one :)

You've caught it! Patchew looks for all of

                               "---",
                               "diff ",
                               "index ",
                               "---",
                               "+++",
                               "@@")

prefixes at the beginning of the lines. This patch doesn't have the
last four, so it doesn't think this is a patch.

It needs to be taught to understand mode changes and binary patches.

Fam
