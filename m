Received: from eggs.gnu.org ([2001:4830:134:3::10]:47500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqK2R-0003dq-RK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqK2N-0006zL-SI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:13:43 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:43353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqK2N-0006y5-Li
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:13:39 -0400
Received: by mail-wm0-x235.google.com with SMTP id f145so6387281wme.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:13:39 -0700 (PDT)
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-3-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170905021201.25684-3-famz@redhat.com>
Date: Fri, 08 Sep 2017 15:13:37 +0100
Message-ID: <87wp59gtwu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 02/12] qemu.py: Add "wait()" method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  scripts/qemu.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 880e3e8219..153f2d1564 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -143,6 +143,13 @@ class QEMUMachine(object):
>              self._post_shutdown()
>              raise
>
> +    def wait(self):
> +        '''Wait for the VM to power off'''
> +        self._popen.wait()
> +        self._qmp.close()
> +        self._load_io_log()
> +        self._post_shutdown()
> +
>      def shutdown(self):
>          '''Terminate the VM and clean up'''
>          if self.is_running():


--
Alex Bennée
