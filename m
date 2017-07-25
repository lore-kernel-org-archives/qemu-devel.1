Received: from eggs.gnu.org ([2001:4830:134:3::10]:37402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1da15D-0004p0-PI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1da158-0002hI-SK
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:45:11 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1da158-0002gY-OJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:45:06 -0400
Received: by mail-it0-f41.google.com with SMTP id v127so52795063itd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:45:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725134512.GF23343@stefanha-x1.localdomain>
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-3-apahim@redhat.com>
	<20170725134512.GF23343@stefanha-x1.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 16:45:05 +0200
Message-ID: <CALAZnb1rukyGGw4gLPb8VFsNNv97oPg8gVJvdTqh3LWqLBRzRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] qemu.py: cleanup and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

On Tue, Jul 25, 2017 at 3:45 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 24, 2017 at 02:44:38PM +0200, Amador Pahim wrote:
>> is_running():
>> - Use Popen.poll() instead of Popen.returncode to check whether
>>   the VM is running or not.
>>
>> exitcode():
>> - Use Popen.poll() instead of Popen.returncode to return an updated
>> exit code.
>>
>> _load_io_log():
>> - Add a try/except to prevent raising exception when qemu io file
>> does not exist.
>>
>> launch():
>> - If VM is already running, do nothing.
>> - If vm is not running but was not cleaned up, call shutdown()
>>   before launching again.
>> - Offload the core of this method to _launch().
>> - Load the args and try to call _launch().
>> - Make sure we cleanup on exception.
>> - On exception, print an error message with the qemu command line
>>   and output.
>>
>> _launch():
>> - Execute _pre_launch(), subprocess.Popen() and self._post_launch().
>> - No try/except here. Any exceptions will be handled by the caller.
>>
>> shutdown():
>> - Make sure self._popen is not None before calling self._popen.wait().
>> - Cleanup the message on negative exit codes.
>> - Always execute self._load_io_log() and self._post_shutdown().
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>
> Please break this up into logical changes and include the rationale for
> making them.  The commit description should explain "why" rather than
> "what" the code change is.

Sure.
