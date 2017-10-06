Received: from eggs.gnu.org ([2001:4830:134:3::10]:53896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TY1-0000u6-9d
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TXx-0008A0-AI
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:24:17 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:55396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TXx-00088z-4m
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:24:13 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <22999.37385.529283.864427@mariner.uk.xensource.com>
Date: Fri, 6 Oct 2017 15:24:09 +0100
In-Reply-To: <CAFEAcA-xTX8sL-ybzTs0p68B522ME=ckLo6NL=A1WV8N8bSwoQ@mail.gmail.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<CAFEAcA-xTX8sL-ybzTs0p68B522ME=ckLo6NL=A1WV8N8bSwoQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, xen-devel@nongnu.org

Peter Maydell writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> On 4 October 2017 at 17:18, Ian Jackson <ian.jackson@eu.citrix.com> wrote:
> >  static void change_process_uid(void)
> >  {
> > -    if (user_pwd) {
> > -        if (setgid(user_pwd->pw_gid) < 0) {
> > +    if (user_pwd || user_uid != (uid_t)-1) {
> > +        if (setgid(user_pwd ? user_pwd->pw_gid : user_gid) < 0) {
> >              fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
> 
> If you're changing the gid we pass to setgid() I think you should
> also change the value we tell the user we tried to use in the
> error message, or it could be rather confusing.

Thanks for the review.  Sorry about the mess here.  I have fixed all
these problems.

Ian.
