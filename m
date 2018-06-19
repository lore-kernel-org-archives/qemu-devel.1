Received: from eggs.gnu.org ([2001:4830:134:3::10]:56828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVEaK-0004EW-Hx
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVEaJ-00060b-L6
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:14:04 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVEaJ-00060X-E3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:14:03 -0400
Received: by mail-ot0-x242.google.com with SMTP id q17-v6so22097664otg.2
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 04:14:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611174243.31070-1-ehabkost@redhat.com>
References: <20180611174243.31070-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 12:13:41 +0100
Message-ID: <CAFEAcA-ZEH+SxhPOoPj+FkgSykikQq0cGUZdXnhvN5C2PE=i6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Python queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 11 June 2018 at 18:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed4582:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180608' into staging (2018-06-08 16:26:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to c7883412440905b41dde7e70f4af782932e80e90:
>
>   python: Remove scripts/ordereddict.py (2018-06-08 16:40:54 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2018-06-11
>
> * Make code compatible with Python 3 using 'futurize --stage1'
> * Require Python >= 2.7 and remove Python 2.6 compatibility
>   modules
>
> ----------------------------------------------------------------

Hi; I noticed that running configure on my machine can now produce a
python traceback from docker.py:

make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg'
config-host.mak is out-of-date, running configure
Traceback (most recent call last):
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 29, in <module>
    from StringIO import StringIO
ImportError: No module named 'StringIO'
Install prefix    /usr/local
[etc]

I don't know if this is because of this change, but this is the
most recent change involving python...

The error also doesn't cause configure to fail, which is probably
a separate bug.

thanks
-- PMM
