Received: from eggs.gnu.org ([2001:4830:134:3::10]:41447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkym-0000d7-Lz
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eEkyl-0005Be-Rb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:50:56 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:55559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eEkyl-0005AV-Mo
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:50:55 -0500
Received: by mail-io0-x242.google.com with SMTP id z74so1690014iof.12
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:50:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109135306.GF18164@redhat.com>
References: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
	<1510202357-124052-1-git-send-email-eswierk@skyportsystems.com>
	<20171109135306.GF18164@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 14 Nov 2017 15:50:14 -0800
Message-ID: <CAO_EM_=H2SN7XsDR668q51hvY-aixScapVT+j9u07VO9CJ0RvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] e1000e: Reimplement e1000 as a
 variant of e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

On Thu, Nov 9, 2017 at 5:53 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> My fear is that this approach of building a new e1000-ng device in
> parallel with having the existing e1000 device is going to cause
> long term pain, possibly never getting to a state where the e1000-ng
> device can replace the e1000 device. Any time there needs to be a
> "big bang" to switch from one impl to another completely different
> impl always causes trouble IME. With need for migration wire format
> & state compatibility, this is even more difficult. From a code review
> POV it will be essentially impossible to have confidence that the new
> impl can be a viable drop-in replacement for the old impl.
>
> Is there really no way that you can change the approach to do a more
> incremental conversion of the existing code base, but still end up in
> the same place at the very end ?
>
> eg just copy all the e1000.c code into the e1000e.c file to start with.
> Then gradually merge functional areas over a longish series of patches
> to eliminate the duplication. This would make it far more practical to
> identify where any regressions come from, and will give reviewers more
> confidence that we're not breaking migration compat.

I agree an incremental conversion is the only realistic way to unearth
potential regressions; testing won't be enough. In the past couple of
days I've run into several cases where e1000 works but e1000-ng
doesn't. Apparently e1000e guest drivers just happen not to tickle
these bugs. So e1000-ng isn't ready for prime time anyway. I'll shelve
this patch series for the moment.

Meanwhile I'll post separate patches for the bugs I've encountered
with e1000 UDP checksum offload.

--Ed
