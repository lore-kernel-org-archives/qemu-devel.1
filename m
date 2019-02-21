Received: from eggs.gnu.org ([209.51.188.92]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwkQt-0006Ax-K4
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwkQr-0002j3-Sc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:14:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gwkQr-0002V0-Gz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:14:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so29063259wrw.5
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 01:14:16 -0800 (PST)
Date: Thu, 21 Feb 2019 10:14:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190221091407.6dbwu7zqg77pssk5@steredhat>
References: <20190220104523.22059-1-pbonzini@redhat.com>
	<87o9764dsb.fsf@zen.linaroharston>
	<b3fe812b-62ac-4b28-416b-4780e11528c0@redhat.com>
	<87lg2a4amz.fsf@zen.linaroharston>
	<6c04a73b-b0f3-2a7d-443e-337e8b637c27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c04a73b-b0f3-2a7d-443e-337e8b637c27@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Vincenzo Maffione <v.maffione@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

CCing Vincenzo, one of the maintainer of Netmap.

On Wed, Feb 20, 2019 at 07:00:19PM +0100, Philippe Mathieu-Daudé wrote:
> On 2/20/19 6:45 PM, Alex Bennée wrote:
> > 
> > Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> > 
> >> On 2/20/19 5:37 PM, Alex Bennée wrote:
> >>> Paolo Bonzini <pbonzini@redhat.com> writes:
> >>>
> >>>> It looks like something in netmap has changed and compilation fails:
> >>>>
> >>>>    install -D libnetmap.a //usr/local/lib/libnetmap.a
> >>>>    install: cannot stat libnetmap.a: No such file or directory
> >>>>
> >>>> Add an explicit "make" step to fix it.
> >>>
> >>> I took an alternate approach as tracking another projects master seems
> >>> like a bad idea:
> >>>
> >>> tests/docker: peg netmap code to a specific version
> >>>
> >>> Tracking head is always going to be at the whims of the upstream.
> >>> Let's use a defined release so things don't magically change under us.
> >>
> >> Oh now I see your reply...
> >>
> >>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >>>
> >>> 1 file changed, 1 insertion(+)
> >>> tests/docker/dockerfiles/debian-amd64.docker | 1 +
> >>>
> >>> modified   tests/docker/dockerfiles/debian-amd64.docker
> >>> @@ -33,6 +33,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> >>>      apt-get install -y --no-install-recommends \
> >>>          linux-headers-amd64
> >>>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
> >>> +RUN cd /usr/src/netmap && git checkout v11.3
> >>
> >> ... and I notice I forgot to change directory in my previous suggestion.
> >>
> >> Why do you take v11.3 and not v11.4?
> >> I agree v11.3 was closer to what I tested when I introduced this
> >> dependency, but I'd rather use the latest release.
> > 
> > Hmm github hid the newer releases by default and has a Latest Release
> > button by v11.3.
> 
> I don't understand (this GitHub feature)...
> 
> I'm talking about this release:
> https://github.com/luigirizzo/netmap/releases/tag/v11.4
> 
> The date is more recent that the v11.3. This looks like the latest
> release to me.
> 
> Anyway I'm fine if you prefer v11.3.
> Please send a formal patch because I don't want to confuse scripts
> adding my R-b in Paolo's patch.
> 
> Regards,
> 
> Phil.
> 

-- 

Stefano Garzarella
Software Engineer @ Red Hat
