Received: from eggs.gnu.org ([2001:4830:134:3::10]:37376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZcW-0002dF-RQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZcV-0003Y0-PX
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRZcV-0003X9-HL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:20:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171218173023.21417-1-armbru@redhat.com>
	<CAFEAcA8TDYqe5hXL7jRn64cBCauSDiTDxDWAGrykE7_j9nqVnQ@mail.gmail.com>
Date: Wed, 20 Dec 2017 09:20:53 +0100
In-Reply-To: <CAFEAcA8TDYqe5hXL7jRn64cBCauSDiTDxDWAGrykE7_j9nqVnQ@mail.gmail.com>
	(Peter Maydell's message of "Tue, 19 Dec 2017 17:44:18 +0000")
Message-ID: <87vah1dd3u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/10] Command line patches for 2017-12-18
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

> On 18 December 2017 at 17:30, Markus Armbruster <armbru@redhat.com> wrote:
>> The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe259:
>>
>>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-12-15-1' into staging (2017-12-17 15:27:41 +0000)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-cmdline-2017-12-18
>>
>> for you to fetch changes up to aa088732820dc26f8881fb7c82bfd75724d18594:
>>
>>   option: Drop unused get_param_value(), get_next_param_value() (2017-12-18 18:16:28 +0100)
>>
>> ----------------------------------------------------------------
>> Command line patches for 2017-12-18
>>
>> ----------------------------------------------------------------
>> Dr. David Alan Gilbert (1):
>>       option: Remove shadowing opt decl from qemu_opt_print()
>>
>> Markus Armbruster (9):
>>       qemu-options: Remove stray colons from output of --help
>>       qemu-options: Fix markup of -netdev l2tpv3
>>       qemu-options qemu-doc: Move "Device URL Syntax" to qemu-doc
>>       qemu-options: Move -iscsi under "Block device options"
>>       qemu-options: Add missing -iscsi Texinfo documentation
>>       qemu-options: Polish section "TPM device options"
>>       qemu-options: Polish section "Character device options"
>>       qemu-options: Belatedly document --watchdog-action inject-nmi
>>       option: Drop unused get_param_value(), get_next_param_value()
>>
>>  include/qemu/option.h  |   5 -
>>  qemu-doc.texi          | 217 +++++++++++++++++++++++++++++++++++
>>  qemu-options-wrapper.h |   2 +-
>>  qemu-options.hx        | 306 ++++++++-----------------------------------------
>>  scripts/hxtool         |   3 +-
>>  util/qemu-option.c     |  36 +-----
>>  6 files changed, 268 insertions(+), 301 deletions(-)
>
> This failed to build on PPC and aarch64 linux:
>
> /home/pm215/qemu/qemu-doc.texi:231: node `sec_invocation' lacks menu
> item for `device_url' despite being its Up target
> make: *** [qemu-doc.txt] Error 1
> make: *** Waiting for unfinished jobs....
> /home/pm215/qemu/qemu-doc.texi:231: node `sec_invocation' lacks menu
> item for `device_url' despite being its Up target
> make: *** [qemu-doc.html] Error 1
>
> and with slightly different errors on openbsd/netbsd/osx:
>   GEN     qemu-doc.txt
> /root/qemu/qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
> /root/qemu/qemu-doc.texi:248: `device_url' has no Up field (perhaps
> incorrect sectioning?).
> /root/qemu/qemu-doc.texi:248: warning: unreferenced node `device_url'.
> makeinfo: Removing output file `qemu-doc.txt' due to errors; use
> --force to preserve.
> Makefile:774: recipe for target 'qemu-doc.txt' failed

Hmm.  Looks like the culprit is a @node we don't actually want.  v2
sent.  Thanks!
