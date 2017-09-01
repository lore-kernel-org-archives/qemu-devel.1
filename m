Received: from eggs.gnu.org ([2001:4830:134:3::10]:51000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dnhkc-0004YQ-QY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dnhkY-0007Rv-5G
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:56:30 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:37688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dnhkX-0007R2-WF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:56:26 -0400
Received: by mail-io0-f173.google.com with SMTP id d78so12656232ioe.4
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 01:56:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831233650.GH7570@localhost.localdomain>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170831233650.GH7570@localhost.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 1 Sep 2017 10:56:23 +0200
Message-ID: <CALAZnb3HMn0eGrXdWMM_1q1Sy0GdLm+nRN+-Fy915m4m0P785Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 00/11] scripts/qemu.py fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Sep 1, 2017 at 1:36 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I was going to queue most of this series except patch 02/11 due
> the "qemu received signal" message log level, but a few conflicts
> prevent the rest of the series from applying cleanly.  Are you
> planning to send v8?

Now I am. Sending asap.

>
> On Fri, Aug 18, 2017 at 07:05:15PM +0200, Amador Pahim wrote:
>> Changes v1->v2:
>>  - Style fixes to make checkpatch.pl happy.
>>  - Rebased.
>> Changes v2->v3:
>>  - Fix typo in patch 3 ("qemu.py: make 'args' public") commit message.
>> Changes v3->v4:
>>  - Squash the 2 first commits since they are co-dependant.
>>  - Cleanup launch() and shutdown().
>>  - Reorder the commits, putting the rename of self._args first.
>>  - Rebased.
>> Changes v4->v5:
>>  - Break the cleanup commit into logical changes and include in the
>>    commit messages the rationale for making them.
>> Changes v5->v6:
>>  - Remove the commit to rename self._args.
>>  - Fix is_running() return before first call to maunch().
>>  - Use python logging system.
>>  - Include the full command line on negative exit code error message.
>>  - Use os.path.null instead of /dev/null.
>>  - Improve the control over the created/deleted files.
>> Changes v6->v7:
>>  - Split commits in self-contained/atomic changes.
>>  - Addressed the comments from previous version, basically improving the
>>    logging messages and the control over created files. See individual
>>    commit messages for details.
>>
>> Amador Pahim (11):
>>   qemu.py: fix is_running() return before first launch()
>>   qemu.py: avoid writing to stdout/stderr
>>   qemu.py: use os.path.null instead of /dev/null
>>   qemu.py: use poll() instead of 'returncode'
>>   qemu.py: cleanup redundant calls in launch()
>>   qemu.py: improve message on negative exit code
>>   qemu.py: include debug information on launch error
>>   qemu.py: make sure we only remove files we create
>>   qemu.py: launch vm only if it's not running
>>   qemu.py: don't launch again before shutdown()
>>   qemu.py: refactor launch()
>>
>>  scripts/qemu.py | 141 ++++++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 106 insertions(+), 35 deletions(-)
>>
>> --
>> 2.13.5
>>
>>
>
> --
> Eduardo
