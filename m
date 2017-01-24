Received: from eggs.gnu.org ([2001:4830:134:3::10]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVqei-0003p0-DU
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 21:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVqeh-0001dD-Iz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 21:16:20 -0500
Date: Tue, 24 Jan 2017 10:15:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170124021559.GA27126@lemon.Home>
References: <20161115225746.3590-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115225746.3590-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] hbitmap: Add
 hbitmap_is_serializable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Tue, 11/15 23:57, Max Reitz wrote:
> This series is a follow-up for "hbitmap: Fix shifts of constants by
> granularity".
> 
> So far, adding the assertion in hbitmap_serialization_granularity() (as
> done by said previous patch) is enough and we know that it will always
> hold true since bitmaps are only serialized as part of a test for now.
> 
> However, in the future we need some other way than a failed assertion to
> tell the user that they cannot serialize a certain bitmap. This series
> adds a function that can be called to tell whether a bitmap can be
> (de-)serialized.

Queued, thanks. I'll send a pull request before the holidays.

Fam
