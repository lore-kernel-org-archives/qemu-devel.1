Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gFAVB-00047a-Ef
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 00:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gFAV7-0000U8-Gp
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 00:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gFAV3-0000NZ-Ay
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 00:10:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181023130440.6323-1-armbru@redhat.com>
	<CAFEAcA9Ob=W85L2wwPisS5p+k9Ah3V_mni3D-ociz-uf2nqL8A@mail.gmail.com>
Date: Wed, 24 Oct 2018 06:10:24 +0200
In-Reply-To: <CAFEAcA9Ob=W85L2wwPisS5p+k9Ah3V_mni3D-ociz-uf2nqL8A@mail.gmail.com>
	(Peter Maydell's message of "Tue, 23 Oct 2018 19:59:39 +0100")
Message-ID: <877ei856j3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v2 00/40] Error reporting patches for
 2018-10-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 23 October 2018 at 14:04, Markus Armbruster <armbru@redhat.com> wrote:
>> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>>
>>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-10-22-v2
>>
>> for you to fetch changes up to 70f81ac4800c5cf33415c966d63bf89af5cefbb9:
>>
>>   error: Drop bogus "use error_setg() instead" admonitions (2018-10-23 14:48:32 +0200)
>>
>> ----------------------------------------------------------------
>> Error reporting patches for 2018-10-22
>>
>> * Replace some unwise uses of error_report() & friends
>> * Print error when using incorrect backend for debugcon
>>
>> ----------------------------------------------------------------
>> v2: Fix a stale sentence in commit message of PATCH 05/40.
>
> Sorry, I'd already pushed the merge of v1 to master before I saw this one.

No biggie.  It was worth a try.
