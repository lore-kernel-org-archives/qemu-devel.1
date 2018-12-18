Received: from eggs.gnu.org ([2001:4830:134:3::10]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJ9-0005R6-B9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJ6-00073e-M0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:08:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJ6-0006zE-EZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:08:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
	<20181213184340.24037-33-armbru@redhat.com>
	<fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com>
	<87k1k8j71u.fsf@dusky.pond.sub.org>
	<dabc589c-0206-708c-0f70-b524f23500a9@redhat.com>
Date: Tue, 18 Dec 2018 11:08:47 +0100
In-Reply-To: <dabc589c-0206-708c-0f70-b524f23500a9@redhat.com> (Thomas Huth's
	message of "Tue, 18 Dec 2018 09:27:41 +0100")
Message-ID: <87imzri1u8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Regression test with --disable options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Thomas Huth <thuth@redhat.com> writes:

> This is the second time in 2 months that compilation with
> --disable-replication broke. So instead of relying on reviews here, I
> think we should catch this with Patchew / some docker based compilation
> test instead that configures the build process with everything disabled,
> e.g.:
>
>  ./configure --enable-werror --disable-rdma --disable-slirp \
>    --disable-curl --disable-capstone --disable-live-block-migration \
>    --disable-glusterfs --disable-replication --disable-coroutine-pool \
>    --disable-smartcard --disable-guest-agent --disable-curses \
>    --disable-libxml2 --disable-tpm --disable-qom-cast-debug \
>    --disable-spice --disable-vhost-vsock  --disable-vhost-net \
>    --disable-vhost-crypto --disable-vhost-user ...
>
> (I'm still one of those docker agnostics ... so if someone wants to come
> up with a patch, I'd be very glad ... otherwise it'll take some time
> 'til I figured it out how to add a docker based test for this...)

In my limited experience, a "disable everything" build requires more
frequent tinkering than I'd like.  A --disable-all would be nice for
this, but I can't spare the time right now.  Any takers?
