Received: from eggs.gnu.org ([2001:4830:134:3::10]:38558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt0ne-0004c8-7a
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt0na-0005tX-84
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dt0na-0005tD-1V
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:17:30 -0400
References: <20170915230744.22942-1-ehabkost@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <eabb65a2-cd0b-e968-2e19-c4c9ac3396a4@redhat.com>
Date: Fri, 15 Sep 2017 20:17:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170915230744.22942-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add Python scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Amador Pahim <apahim@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 09/15/2017 07:07 PM, Eduardo Habkost wrote:
> Cleber and I are volunteering to review and queue patches for the
> Python scripts and modules in scripts/.
> 
> I'm setting "M: Odd fixes" because not all scripts are actively
> maintained.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Even before this patch is merged, I plan to send a pull request
> including some patches for the Python code soon.
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c333aba21..2c3b8ecde7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1390,6 +1390,13 @@ S: Maintained
>  F: include/sysemu/cryptodev*.h
>  F: backends/cryptodev*.c
>  
> +Python scripts
> +M: Eduardo Habkost <ehabkost@redhat.com>
> +M: Cleber Rosa <crosa@redhat.com>
> +S: Odd fixes
> +F: scripts/qmp/*
> +F: scripts/*.py
> +
>  QAPI
>  M: Markus Armbruster <armbru@redhat.com>
>  M: Michael Roth <mdroth@linux.vnet.ibm.com>
> 

I rather like the thought of having dedicated Python maintainers who can
review python code with an eye for what is idiomatic. I am fairly
certain the python I write is functional, but I'm rarely sure it's what
a python programmer would do.

I suppose you are intentionally omitting any python that exists as part
of the test infrastructure, however?

John
