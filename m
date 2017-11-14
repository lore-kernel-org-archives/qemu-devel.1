Received: from eggs.gnu.org ([2001:4830:134:3::10]:35917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbO3-0003v0-Dz
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbO0-0000Q0-R2
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbO0-0000P7-Hg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:36:20 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081824.27640.82263.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7261dd7-59d9-d8dd-8d68-2a78e19a5a6a@redhat.com>
Date: Tue, 14 Nov 2017 14:36:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081824.27640.82263.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 20/26] replay: don't destroy mutex
 at exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 14/11/2017 09:18, Pavel Dovgalyuk wrote:
> Replay mutex is held by vCPU thread and destroy function is called
> from atexit of the main thread. Therefore we cannot destroy it safely.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> ---
>  replay/replay.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/replay/replay.c b/replay/replay.c
> index 6e34b79..be1d4a2 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -357,7 +357,6 @@ void replay_finish(void)
>      replay_snapshot = NULL;
>  
>      replay_finish_events();
> -    replay_mutex_destroy();
>  }
>  
>  void replay_add_blocker(Error *reason)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
