Received: from eggs.gnu.org ([209.51.188.92]:54889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnjG-0003mR-Nh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnjE-0002kT-J8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:32:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqnjA-0002cl-OD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:32:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so1764913wrw.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 15:32:28 -0800 (PST)
References: <154931335810.29184.7999220470596987389@ebba9967afc0>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <add6e25b-d3e8-e352-6a0f-2457555f2dfd@redhat.com>
Date: Tue, 5 Feb 2019 00:32:25 +0100
MIME-Version: 1.0
In-Reply-To: <154931335810.29184.7999220470596987389@ebba9967afc0>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/input/tsc210x: Fix building with no
 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: fam@euphon.net, qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, patchew-devel@redhat.com

On 2/4/19 9:49 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190204204517.23698-1-philmd@redhat.com/
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=1 J=14
> === TEST SCRIPT END ===
> 
> The full log is available at
> http://patchew.org/logs/20190204204517.23698-1-philmd@redhat.com/testing.docker-mingw@fedora/?type=message.
> ---

Full log is weird:

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>From https://github.com/patchew-project/qemu
 - [tag update]
patchew/20190117215300.29694-1-brijesh.singh@amd.com ->
patchew/20190117215300.29694-1-brijesh.singh@amd.com
fatal: Unable to create
'/home/patchew/.cache/patchew-git-cache/httpsgithubcompatchewprojectqemu-3c8cf5a9c21ff8782164d1def7f44bd888713384/refs/tags/patchew/20190204204517.23698-1-philmd@redhat.com.lock':
File exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
Unexpected end of command stream
error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
Traceback (most recent call last):
  File "patchew-tester/src/patchew-cli", line 521, in test_one
    git_clone_repo(clone, r["repo"], r["head"], logf, True)
  File "patchew-tester/src/patchew-cli", line 48, in git_clone_repo
    stdout=logf, stderr=logf)
  File "/usr/lib64/python3.4/subprocess.py", line 558, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f',
'--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384',
'https://github.com/patchew-project/qemu']' returned non-zero exit status 1
