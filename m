Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0kgJ-0008Tk-VS
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0kgE-0002aD-Op
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:14:15 -0400
References: <20180323225739.17329-1-laurent@vivier.eu>
	<20180323225739.17329-10-laurent@vivier.eu>
	<20180327104706.5363eda9.cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <606ca3cc-f96e-2d39-df97-b5ec80d2e7a9@vivier.eu>
Date: Tue, 27 Mar 2018 11:13:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180327104706.5363eda9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 09/20] linux-user: move s390x
 signal.c parts to s390x directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

Le 27/03/2018 à 10:47, Cornelia Huck a écrit :
> On Fri, 23 Mar 2018 23:57:28 +0100
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> No code change, only move code from signal.c to
>> s390x/signal.c, except adding includes and
>> exporting setup_frame() and setup_rt_frame().
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/s390x/signal.c        | 309 +++++++++++++++++++++++++++++++++++++++
>>  linux-user/s390x/target_signal.h |   6 +-
>>  linux-user/signal.c              | 306 --------------------------------------
>>  3 files changed, 314 insertions(+), 307 deletions(-)
> 
> I'm not too emotionally involved with linux-user, but

I use git-publish and it automatically copies people in the MAINTAINERS
file (in your case because of "K: ^Subject:.*(?i)s390x?").

> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 

Thank you!

Laurent
