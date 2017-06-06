Received: from eggs.gnu.org ([2001:4830:134:3::10]:40186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dIE5L-0003vo-Vo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bru.dominguez@gmail.com>) id 1dIE5K-00067Q-Tp
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:59:48 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bru.dominguez@gmail.com>)
	id 1dIE5K-00066I-LP
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:59:46 -0400
Received: by mail-wm0-x242.google.com with SMTP id g15so34762863wmc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 05:59:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QU_vbVpaaC54Wh2JFAiXg+XF9K=KDdVJyAQFiBEZbZ2BQ@mail.gmail.com>
References: <CALfaEa0MirxK6ESnepptGLiugYZBOSQVxe=R72h+c_-GBXkYzQ@mail.gmail.com>
	<20170606092831.GA8013@stefanha-x1.localdomain>
	<CALfaEa0T+rcZjmehm=Rdr+NOApTOKsizpCWcQ6ssErhU=nuUTA@mail.gmail.com>
	<CAJSP0QXffef=Ds7SeTFeCWi7iAjjUarUBzvc+hzLc6AhzQwMsA@mail.gmail.com>
	<CALfaEa1Uqo-uW5y01oCoCxAHUxzDjHTEcLF505Uk0Tg47Kk-Ew@mail.gmail.com>
	<CAJSP0QU_vbVpaaC54Wh2JFAiXg+XF9K=KDdVJyAQFiBEZbZ2BQ@mail.gmail.com>
From: Bruno Dominguez <bru.dominguez@gmail.com>
Date: Tue, 6 Jun 2017 13:59:44 +0100
Message-ID: <CALfaEa0sEm4B_5QTB-T80VQTF_54f3MaDeOZSmGfsgYkkmxNnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] split c and cxx extra flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

ok, thanks for the clarification.

2017-06-06 13:38 GMT+01:00 Stefan Hajnoczi <stefanha@gmail.com>:
> On Tue, Jun 6, 2017 at 1:20 PM, Bruno Dominguez <bru.dominguez@gmail.com> wrote:
>> sending again the patch with the correct format and:
>>
>> 1. Matching --extra-cxxflags description with --cxx
>> 2. Removing some extra spaces indicated by checkpatch script.
>
> The code looks fine to me:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> A few more points about patch submission:
>
> All email body text above '---' is the commit description that is
> included in the git log.  Therefore the commit description should only
> contain information that is useful in the version history, like the
> rationale for this commit.
>
> Please put changelog information below '---' so it does not become
> part of the git log.  Once the patch has been merged it's not useful
> to know that you're "sending again the patch with the correct format
> and:" and so on.
>
> The submission guidelines page says "send each new revision as a new
> top-level thread, rather than burying it in-reply-to an earlier
> revision, as many reviewers are not looking inside deep threads for
> new patches".
>
> There are tools that make it easy to send and manage patch series.
> That way you don't have to invoke git-format-patch/git-send-email and
> perform manual steps.  The tool I use is git-publish:
> https://github.com/stefanha/git-publish
>
> Putting this all together, please send a new top-level email like this:
>
> Subject: [PATCH v2] configure: split c and cxx extra flags
>
> There was no possibility to add specific cxx flags using the configure
> file. So A new entrance has been created to support it.
>
> Duplication of information in configure and rules.mak. Taking
> QEMU_CFLAGS and add them to QEMU_CXXFLAGS, now the value of
> QEMU_CXXFLAGS is stored in config-host.mak, so there is no need for
> it.
>
> The makefile for libvixl was adding flags for QEMU_CXXFLAGS in
> QEMU_CFLAGS because of the addition in rules.mak. That was removed, so
> adding them where it should be.
>
> Signed-off-by: Bruno Dominguez <bru.dominguez@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Matching --extra-cxxflags description with --cxx
>  * Removing some extra spaces indicated by checkpatch script
>  * Fixed patch format
>
> ...
