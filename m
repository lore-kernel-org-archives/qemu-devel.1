Received: from eggs.gnu.org ([2001:4830:134:3::10]:47539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dDC7P-00056a-Qu
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dDC7O-0005rg-SR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:53:07 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ianloic@google.com>) id 1dDC7O-0005qX-Le
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:53:06 -0400
Received: by mail-wm0-x235.google.com with SMTP id d127so31583279wmf.0
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20170522180217.18234-1-ianloic@google.com>
	<1495533796.30747.2.camel@redhat.com>
In-Reply-To: <1495533796.30747.2.camel@redhat.com>
From: Ian McKellar <ianloic@google.com>
Date: Tue, 23 May 2017 15:52:52 +0000
Message-ID: <CA+YAivh=GjS5P_3BXccj5tYSxNSQoHQfeTvjgCQfVtw5QwY=_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, May 23, 2017 at 3:03 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Sounds like this happens in case there is a modifier state change
> without linked key event, such as state change while qemu did not have
> the keyboard focus.  Nice that macos sends notifications in that case.
>

Yeah, I guess it makes sense to send an event to update modifier state when
keyboard focus returns.

>
> I'm wondering whenever we should just use modifierFlags all the time.
>

Probably. My initial patch tried to be minimally intrusive but I can try
reworking the NSEventTypeFlagsChanged handling to compare the new
modifierFlags to the last we've seen and synthesize the appropriate key
down/up events.

Ian
