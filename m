Received: from eggs.gnu.org ([2001:4830:134:3::10]:53029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clYS0-0002nZ-Mg
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clYRz-0006NA-Pg
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:04:08 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clYRz-0006Mw-Iw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:04:07 -0500
Received: by mail-wm0-x236.google.com with SMTP id v186so110545057wmd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 02:04:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 11:03:44 +0100
Message-ID: <CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 8 March 2017 at 09:26, Thomas Huth <thuth@redhat.com> wrote:
> But anyway, the more important thing that keeps me concerned is: Someone
>  once told me that we should get rid of old parameters and interfaces
> (like HMP commands) primarily only when we're changing to a new major
> version number. As you all know, QEMU has a lot of legacy options, which
> are likely rather confusing than helpful for the new users nowadays,
> e.g. things like the "-net channel" option (which is fortunately even
> hardly documented), but maybe also even the whole vlan/hub concept in
> the net code, or legacy parameters like "-usbdevice". If we switch to
> version 3.0, could we agree to remove at least some of them?

I think if we are going to deprecate and remove options we need
a clear transition plan for doing so, which means at least one
release where options are "still works, but warn that they
are going away with pointer to documentation or similar info
about their replacement syntax", before actually dropping them.

(Similar applies if we want to deprecate and remove old and
unmaintained machine models.)

thanks
-- PMM
