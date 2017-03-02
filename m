Received: from eggs.gnu.org ([2001:4830:134:3::10]:58834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjSbp-0007c2-2l
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjSbn-0004qV-5W
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:25:37 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjSbm-0004pi-Uh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:25:35 -0500
Received: by mail-wm0-x235.google.com with SMTP id n11so27267235wma.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 07:25:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 15:25:13 +0000
Message-ID: <CAFEAcA8WXnBXQ-qNmzRw6yD_tuYLQepmSC0be50s8h=-1r-VQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 22:25, Markus Armbruster <armbru@redhat.com> wrote:
> Actually, the command line option is the least part of this series.
> Its bulk is about building infrastructure and getting errors out of
> the JSON parser[*].  The latter part could be spun out in its own
> series, if that helps.  We'll see.
>
> The design of the command line interface was discussed here:
> Subject: Non-flat command line option argument syntax
> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:
>
>   vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-28
>
> for you to fetch changes up to cf66cd3cad56827ae943cc6d752ec619f448b7d7:
>
>   keyval: Support lists (2017-02-28 23:17:56 +0100)
>
> ----------------------------------------------------------------
> block: Command line option -blockdev
>

make check failures on OSX host:

  GTESTER check-qtest-mips
  GTESTER check-qtest-mips64
Broken pipe
GTester: last random seed: R02S52f9c996ae3acbcbb3d4c5231ff7098e
  GTESTER check-qtest-mips64el
  GTESTER check-qtest-mipsel
  GTESTER check-qtest-moxie
  GTESTER check-qtest-nios2
  GTESTER check-qtest-or1k
  GTESTER check-qtest-ppc
  GTESTER check-qtest-ppc64
  GTESTER check-qtest-ppcemb
  GTESTER check-qtest-s390x
  GTESTER check-qtest-sh4
Broken pipe
GTester: last random seed: R02S1e96ff49370f71f63240c3a6bb3c1aa7
Broken pipe
GTester: last random seed: R02S4bbfc4e42ade410e3dd44c93250c59b8
  GTESTER check-qtest-sh4eb
Broken pipe
GTester: last random seed: R02Sa22f920582e624373c4ca48eb3e707a3
  GTESTER check-qtest-sparc
Broken pipe
GTester: last random seed: R02Sb47b7d1736ce92e44ef4b913aa90a500
Broken pipe
GTester: last random seed: R02S14ec758ef2ee853ec65f24b7850fe3f4
Broken pipe
GTester: last random seed: R02Sde4dad4558fbe4522cb4b60443c5ead5
Broken pipe
GTester: last random seed: R02Se6220bcd0ec342bd3c6328ee66ed8f45
Broken pipe
GTester: last random seed: R02Sba7d358af8f414b8a3e25bb7e3ec50ef
make: *** [check-qtest-sparc] Error 1

May or may not be this pull's fault.

thanks
-- PMM
