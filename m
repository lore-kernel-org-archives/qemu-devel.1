Received: from eggs.gnu.org ([2001:4830:134:3::10]:44089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gXouo-0006i6-AL
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gXouj-0002TP-B8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:58:10 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:36786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gXouj-0002Qk-3o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:58:05 -0500
Received: by mail-it1-f174.google.com with SMTP id c9so9694587itj.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:58:04 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<20181207095417.GF13784@redhat.com>
In-Reply-To: <20181207095417.GF13784@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 14 Dec 2018 09:57:50 -0500
Message-ID: <CAPyFy2AxmXSu8NsVpTWtKQYbjrL+72GvCUpQ=T=ffooyQPov4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, 7 Dec 2018 at 04:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> Looking at this more generally I see they support Linux containers,
> native Windows containers, macOS and FreeBSD. IOW, they offer more
> platforms than our current Travis setup does and aren't stuck on an
> amcient Ubuntu version.

Indeed - having a hosted CI service to build on FreeBSD is something
I've wanted for a long time; so much better if one service can support
most or all platforms of interest.

> One key thing I can't find out is what, if any, limitations they put
> on resources used by the free service for OSS projects.  Does anyone
> know if they limit the number of concurrent build jobs like Travis
> does ? Do they put a fixed time limit on execution of a single job ?

I'm not sure what concurrency limits they have. I have empirically
discovered a 1hr limit for a job to complete, but I believe it can be
increased via the config file.
