Received: from eggs.gnu.org ([2001:4830:134:3::10]:46414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdRL-0000Qw-UQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdRH-0002Bz-V4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:59 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebdRH-000221-Ox
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id e11so10716981pff.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:26:49 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
Message-ID: <efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
Date: Wed, 17 Jan 2018 10:26:36 +0800
MIME-Version: 1.0
In-Reply-To: <20180112125000.27256-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/7] docker: update Ubuntu and Fedora
 images, deprecate old ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org



On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> This series is to be clearer about which upstream version we are using.
>
> All "FROM distrib:latest" entries have now been removed and replaced by
> explicit "FROM distrib:version" ones.
>
> To keep backward compatibility, a warning is displayed to the user,
> suggesting which correct base image to use.
>
> To be consistent, we remove the deprecated images of the "make docker" output.

Changing image names when a new release comes out is not maintainable 
for Fedora and Ubuntu because of the fast pace. Therefore I prefer 
Paolo's simple patch.

Maybe you can somehow create an alias in Makefile to point "fedora" to 
"fedora${last_release_num}", and update it when adding a new release. 
But still I don't think keeping more than one fedora dockerfiles is very 
useful.

In principle, we use Debian, CentOS and ubuntu-lts to cover long living 
releases and {ubuntu,fedora}:latest to cover cutting edge releases. 
Spending effort on tests is better than adding more versions, IMO.

Thanks,

Fam

>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daudé (7):
>    docker: sort images list displayed by 'make docker'
>    docker: do not display deprecated images in 'make docker' help
>    docker: add the Ubuntu Trusty base image
>    docker: do not use Trusty APT source in Xenial
>    docker: warn users to use ubuntu16.04 for the LTS Xenial image
>    docker: add the Fedora 27 base image
>    docker: warn users to use newer fedora25/fedora27 base image
>
>   tests/docker/Makefile.include               |  5 ++++-
>   tests/docker/dockerfiles/fedora.docker      | 29 ++++++++++++-----------------
>   tests/docker/dockerfiles/fedora25.docker    | 18 ++++++++++++++++++
>   tests/docker/dockerfiles/fedora27.docker    | 18 ++++++++++++++++++
>   tests/docker/dockerfiles/ubuntu.docker      | 28 ++++++++++------------------
>   tests/docker/dockerfiles/ubuntu14.04.docker | 17 +++++++++++++++++
>   tests/docker/dockerfiles/ubuntu16.04.docker | 16 ++++++++++++++++
>   7 files changed, 95 insertions(+), 36 deletions(-)
>   create mode 100644 tests/docker/dockerfiles/fedora25.docker
>   create mode 100644 tests/docker/dockerfiles/fedora27.docker
>   create mode 100644 tests/docker/dockerfiles/ubuntu14.04.docker
>   create mode 100644 tests/docker/dockerfiles/ubuntu16.04.docker
>
