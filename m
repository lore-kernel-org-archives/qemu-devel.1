Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYaKB-0000Sd-AO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYaKA-0003X6-H6
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:26:27 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:33856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYaKA-0003Wz-Cx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:26:26 -0500
Received: by mail-vk0-x236.google.com with SMTP id r136so239311515vke.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 07:26:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c6c5267a-58df-061b-8dd3-73d691d37578@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
	<CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
	<c6c5267a-58df-061b-8dd3-73d691d37578@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 15:26:05 +0000
Message-ID: <CAFEAcA_rPxu8tmHn88t4odtCA1ZCK4iPsRB8+jLqk13k2u90yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 31 January 2017 at 15:16, Eric Blake <eblake@redhat.com> wrote:
> The do-nothing fallback works for me; I'm just debating whether it is
> dead code or whether we really would have a user building with a
> compiler that old.

OSX 10.6's clang (whatever that was) is probably the most
likely I'd guess.

If we did want to require a newer compiler there are a
bunch of QEMU_GNUC_PREREQ(3,4) calls that could be
obsoleted. But we should probably do that as a separate
thread to get some consensus on what the minimum version
should be, and put a helpful check in configure and
a line in the release notes and so on...

thanks
-- PMM
