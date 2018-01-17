Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebh99-0006ih-Ur
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebh95-00012w-17
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:24:27 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:43659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebh94-00012V-SB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:24:22 -0500
Received: by mail-it0-f44.google.com with SMTP id u62so7848601ita.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 22:24:22 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <151616908700.575.7368076470257215397@5adcb62bf0d6>
Message-ID: <efbd1278-36e1-6f5b-773d-05a4244a8767@redhat.com>
Date: Wed, 17 Jan 2018 14:24:11 +0800
MIME-Version: 1.0
In-Reply-To: <151616908700.575.7368076470257215397@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com



On 01/17/2018 02:04 PM, no-reply@patchew.org wrote:
>    BUILD   min-glib
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 407, in <module>
>      sys.exit(main())
>    File "./tests/docker/docker.py", line 404, in main
>      return args.cmdobj.run(args, argv)
>    File "./tests/docker/docker.py", line 287, in run
>      dkr = Docker()
>    File "./tests/docker/docker.py", line 133, in __init__
>      self._command = _guess_docker_command()
>    File "./tests/docker/docker.py", line 58, in _guess_docker_command
>      commands_txt)
> Exception: Cannot find working docker command. Tried:
>    docker
>    sudo -n docker

Patchew.org was misconfigured to run this docker tests on a host that 
has no docker. Fixed now. Sorry for the noise.

Fam
