Received: from eggs.gnu.org ([2001:4830:134:3::10]:55012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBIO-0006cp-0r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBIM-00071U-SL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:17:11 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<9b840c1229f3e25cf8ccf0d27bfabf37c751d5e1.1504111803.git.jcody@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7dc65a38-c92e-32d5-8b35-c790ee09bd68@redhat.com>
Date: Wed, 30 Aug 2017 18:17:01 -0400
MIME-Version: 1.0
In-Reply-To: <9b840c1229f3e25cf8ccf0d27bfabf37c751d5e1.1504111803.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qemu-iotests: remove file cleanup
 from bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, stefanha@redhat.com



On 08/30/2017 12:52 PM, Jeff Cody wrote:
> All files for a given test are now self-contained in a subdirectory,
> and therefore the "./check" script can do all file-related cleanup
> without any help.
> 
> This removes file cleanups from the bash tests.  The only cleanup left
> is whatever is needed to kill any spawned processes; e.g. _cleanup_qemu.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/001     |  6 ------
>  tests/qemu-iotests/002     |  6 ------
>  tests/qemu-iotests/003     |  6 ------
>  tests/qemu-iotests/004     |  6 ------
>  tests/qemu-iotests/005     |  6 ------
>  tests/qemu-iotests/007     |  7 -------
>  tests/qemu-iotests/008     |  6 ------
>  tests/qemu-iotests/009     |  6 ------
>  tests/qemu-iotests/010     |  6 ------
>  tests/qemu-iotests/011     |  6 ------
>  tests/qemu-iotests/012     |  6 ------
>  tests/qemu-iotests/013     |  6 ------
>  tests/qemu-iotests/014     |  6 ------
>  tests/qemu-iotests/015     |  7 -------
>  tests/qemu-iotests/017     |  6 ------
>  tests/qemu-iotests/018     |  6 ------
>  tests/qemu-iotests/019     |  8 --------
>  tests/qemu-iotests/020     |  8 --------
>  tests/qemu-iotests/021     |  6 ------
>  tests/qemu-iotests/022     |  6 ------
>  tests/qemu-iotests/023     |  6 ------
>  tests/qemu-iotests/024     |  8 --------
>  tests/qemu-iotests/025     |  6 ------
>  tests/qemu-iotests/026     |  7 -------
>  tests/qemu-iotests/027     |  6 ------
>  tests/qemu-iotests/028     |  8 --------
>  tests/qemu-iotests/029     |  7 -------
>  tests/qemu-iotests/031     |  6 ------
>  tests/qemu-iotests/032     |  6 ------
>  tests/qemu-iotests/033     |  6 ------
>  tests/qemu-iotests/034     |  6 ------
>  tests/qemu-iotests/035     |  6 ------
>  tests/qemu-iotests/036     |  6 ------
>  tests/qemu-iotests/037     |  6 ------
>  tests/qemu-iotests/038     |  6 ------
>  tests/qemu-iotests/039     |  6 ------
>  tests/qemu-iotests/042     |  6 ------
>  tests/qemu-iotests/043     |  7 -------
>  tests/qemu-iotests/046     |  6 ------
>  tests/qemu-iotests/047     |  6 ------
>  tests/qemu-iotests/048     |  8 --------
>  tests/qemu-iotests/048.out |  1 -
>  tests/qemu-iotests/049     |  6 ------
>  tests/qemu-iotests/050     |  8 --------
>  tests/qemu-iotests/051     |  6 ------
>  tests/qemu-iotests/052     |  6 ------
>  tests/qemu-iotests/053     |  7 -------
>  tests/qemu-iotests/054     |  6 ------
>  tests/qemu-iotests/058     |  8 +-------
>  tests/qemu-iotests/059     |  7 -------
>  tests/qemu-iotests/060     |  6 ------
>  tests/qemu-iotests/061     |  6 ------
>  tests/qemu-iotests/062     |  6 ------
>  tests/qemu-iotests/063     |  7 -------
>  tests/qemu-iotests/064     |  6 ------
>  tests/qemu-iotests/066     |  6 ------
>  tests/qemu-iotests/068     |  6 ------
>  tests/qemu-iotests/069     |  6 ------
>  tests/qemu-iotests/070     |  6 ------
>  tests/qemu-iotests/071     |  6 ------
>  tests/qemu-iotests/072     |  6 ------
>  tests/qemu-iotests/073     |  6 ------
>  tests/qemu-iotests/074     |  9 ---------
>  tests/qemu-iotests/074.out |  1 -
>  tests/qemu-iotests/075     |  6 ------
>  tests/qemu-iotests/076     |  6 ------
>  tests/qemu-iotests/077     |  6 ------
>  tests/qemu-iotests/078     |  6 ------
>  tests/qemu-iotests/079     |  6 ------
>  tests/qemu-iotests/080     |  7 -------
>  tests/qemu-iotests/081     |  8 --------
>  tests/qemu-iotests/082     |  6 ------
>  tests/qemu-iotests/084     |  6 ------
>  tests/qemu-iotests/085     | 13 +------------
>  tests/qemu-iotests/086     |  6 ------
>  tests/qemu-iotests/088     |  7 -------
>  tests/qemu-iotests/089     |  6 ------
>  tests/qemu-iotests/090     |  6 ------
>  tests/qemu-iotests/091     |  8 +-------
>  tests/qemu-iotests/092     |  7 -------
>  tests/qemu-iotests/094     |  9 +--------
>  tests/qemu-iotests/095     |  8 +-------
>  tests/qemu-iotests/097     |  7 -------
>  tests/qemu-iotests/098     |  7 -------
>  tests/qemu-iotests/099     |  6 ------
>  tests/qemu-iotests/101     |  6 ------
>  tests/qemu-iotests/102     |  7 +------
>  tests/qemu-iotests/103     |  6 ------
>  tests/qemu-iotests/104     |  2 --
>  tests/qemu-iotests/105     |  6 ------
>  tests/qemu-iotests/106     |  6 ------
>  tests/qemu-iotests/107     |  6 ------
>  tests/qemu-iotests/108     |  6 ------
>  tests/qemu-iotests/109     |  8 +-------
>  tests/qemu-iotests/110     |  6 ------
>  tests/qemu-iotests/111     |  6 ------
>  tests/qemu-iotests/112     |  6 ------
>  tests/qemu-iotests/113     |  6 ------
>  tests/qemu-iotests/114     |  6 ------
>  tests/qemu-iotests/115     |  6 ------
>  tests/qemu-iotests/116     |  6 ------
>  tests/qemu-iotests/117     |  7 +------
>  tests/qemu-iotests/119     |  6 ------
>  tests/qemu-iotests/120     |  6 ------
>  tests/qemu-iotests/121     |  6 ------
>  tests/qemu-iotests/122     |  7 -------
>  tests/qemu-iotests/123     |  7 -------
>  tests/qemu-iotests/125     |  6 ------
>  tests/qemu-iotests/130     |  7 +------
>  tests/qemu-iotests/131     |  6 ------
>  tests/qemu-iotests/133     |  6 ------
>  tests/qemu-iotests/134     |  6 ------
>  tests/qemu-iotests/135     |  6 ------
>  tests/qemu-iotests/137     |  6 ------
>  tests/qemu-iotests/138     |  6 ------
>  tests/qemu-iotests/140     |  8 +-------
>  tests/qemu-iotests/141     |  8 +-------
>  tests/qemu-iotests/142     |  7 -------
>  tests/qemu-iotests/143     |  7 +------
>  tests/qemu-iotests/144     |  8 +-------
>  tests/qemu-iotests/145     |  7 -------
>  tests/qemu-iotests/146     |  7 +------
>  tests/qemu-iotests/150     |  6 ------
>  tests/qemu-iotests/153     | 12 ------------
>  tests/qemu-iotests/154     |  6 ------
>  tests/qemu-iotests/156     |  7 +------
>  tests/qemu-iotests/157     |  6 ------
>  tests/qemu-iotests/158     |  6 ------
>  tests/qemu-iotests/159     |  7 -------
>  tests/qemu-iotests/160     |  7 -------
>  tests/qemu-iotests/162     |  7 -------
>  tests/qemu-iotests/170     |  7 -------
>  tests/qemu-iotests/171     |  6 ------
>  tests/qemu-iotests/172     |  8 --------
>  tests/qemu-iotests/173     |  8 +-------
>  tests/qemu-iotests/174     |  6 ------
>  tests/qemu-iotests/175     |  6 ------
>  tests/qemu-iotests/176     |  7 -------
>  tests/qemu-iotests/177     |  6 ------
>  tests/qemu-iotests/178     |  7 -------
>  tests/qemu-iotests/179     |  7 -------
>  tests/qemu-iotests/181     |  8 +-------
>  tests/qemu-iotests/182     |  6 ------
>  tests/qemu-iotests/183     |  9 +--------
>  tests/qemu-iotests/185     |  9 +--------
>  tests/qemu-iotests/186     |  6 ------
>  tests/qemu-iotests/187     |  8 --------
>  tests/qemu-iotests/188     |  6 ------
>  tests/qemu-iotests/189     |  6 ------
>  tests/qemu-iotests/190     |  7 -------
>  tests/qemu-iotests/192     |  6 ------
>  151 files changed, 19 insertions(+), 965 deletions(-)

wild diffstat.

Reviewed-by: John Snow <jsnow@redhat.com>
