Received: from eggs.gnu.org ([2001:4830:134:3::10]:59400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuK6v-0001ac-1u
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuK6u-0000br-AD
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:11:25 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fuK6t-0000aM-PN
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:11:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id 8-v6so28300803oip.0
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 09:11:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1535381652-19870-5-git-send-email-thuth@redhat.com>
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
	<1535381652-19870-5-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Aug 2018 17:11:00 +0100
Message-ID: <CAFEAcA9xaUHZ5qg-21w9-J+9znKjTqJR+uW6B5SpMr2woWvjTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] net: Remove the deprecated -tftp,
 -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

On 27 August 2018 at 15:54, Thomas Huth <thuth@redhat.com> wrote:
> These options likely do not work as expected as soon as the user
> tries to use more than one network interface at once. The parameters
> have been marked as deprecated since QEMU v2.6, so users had plenty
> of time to move their scripts to the new syntax.

I still haven't changed my scripts, because the warning
message if you use -redir still doesn't tell you what
exactly the new syntax option equivalent is...

thanks
-- PMM
