Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d41dI-0000Op-MM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d41dD-00011c-Tr
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d41dD-000118-N7
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:52:03 -0400
Date: Fri, 28 Apr 2017 14:21:56 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170428075612.9997-1-kraxel@redhat.com>
Message-ID: <alpine.LFD.2.20.1704281415120.29240@wniryva>
References: <20170428075612.9997-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] audio: release capture buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Huawei PSIRT <PSIRT@huawei.com>

+-- On Fri, 28 Apr 2017, Gerd Hoffmann wrote --+
| AUD_add_capture() allocates two buffers which get never released.

 which get never -> which are never ...

| Impact: Allows vnc clients to exhaust host memory by repeatly

 repeatly -> repeatedly


| diff --git a/audio/audio.c b/audio/audio.c
| index c8898d8422..beafed209b 100644
| --- a/audio/audio.c
| +++ b/audio/audio.c
| @@ -2028,6 +2028,8 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
|                      sw = sw1;
|                  }
|                  QLIST_REMOVE (cap, entries);
| +                g_free (cap->hw.mix_buf);
| +                g_free (cap->buf);
|                  g_free (cap);
|              }
|              return;

Looks okay.
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
