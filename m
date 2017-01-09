Received: from eggs.gnu.org ([2001:4830:134:3::10]:35054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQhfZ-00015q-PW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQhfZ-000219-4c
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:39:57 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQhfZ-000215-0U
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:39:57 -0500
Received: by mail-vk0-x22a.google.com with SMTP id 137so348810086vkl.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 13:39:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109201340.16593-4-dgilbert@redhat.com>
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-4-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 21:39:36 +0000
Message-ID: <CAFEAcA_5+WJtRSdOjTw+43Y6R_khLcQu5=yG7Hgu1v+KKbr8Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/3] vmstate registration: check return
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

On 9 January 2017 at 20:13, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Check qdev's call to vmstate_register_with_alias_id; that gets
> most of the common uses; there's hundreds of calls via vmstate_register
> which could get fixed over time.

Not quite that bad, I think -- I make it just over 50 calls.

thanks
-- PMM
