Received: from eggs.gnu.org ([2001:4830:134:3::10]:49119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAC6F-0007HL-PM
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAC6C-00012z-Ia
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:52:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAC69-00011a-Vs
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:52:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so4924080wmg.0
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:52:13 -0700 (PDT)
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37f2cf1f-c164-5cc9-3ea5-53a03d92414d@redhat.com>
Date: Wed, 10 Oct 2018 12:52:11 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] scripts/qemu.py: add method and
 private attribute for arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/10/2018 01:26, Cleber Rosa wrote:
> Because some sane defaults may require the knowledge of the arch,
> let's give the QEMUMachine the opportunity to hold that information.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/qemu.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f099ce7278..d9e24a0c1a 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -113,6 +113,7 @@ class QEMUMachine(object):
>          self._test_dir = test_dir
>          self._temp_dir = None
>          self._launched = False
> +        self._arch = None
>          self._machine = None
>          self._console_device_type = None
>          self._console_address = None
> @@ -406,6 +407,12 @@ class QEMUMachine(object):
>          '''
>          self._args.extend(args)
>  
> +    def set_arch(self, arch):
> +        """
> +        Sets the architecture of this machine
> +        """
> +        self._arch = arch
> +
>      def set_machine(self, machine_type):
>          '''
>          Sets the machine type
> 
