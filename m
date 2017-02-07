Received: from eggs.gnu.org ([2001:4830:134:3::10]:41252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb31S-0004nx-OX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb31R-00044w-Vu
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:29:18 -0500
Date: Tue, 7 Feb 2017 18:29:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170207102909.GI19280@lemon.lan>
References: <cover.1485365834.git.jcody@redhat.com>
	<56f34791aae2b2b5dff23ea927dfa42b54d452c6.1485365834.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f34791aae2b2b5dff23ea927dfa42b54d452c6.1485365834.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] QAPI: Fix blockdev-add example
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

On Wed, 01/25 12:42, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  qapi/block-core.json | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4ebb8d8..adc089f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2909,21 +2909,24 @@
>  # 1.
>  # -> { "execute": "blockdev-add",
>  #      "arguments": {
> -#          "options" : { "driver": "qcow2",
> -#                        "file": { "driver": "file",
> -#                                  "filename": "test.qcow2" } } } }
> +#           "driver": "qcow2",
> +#           "node-name": "test1",
> +#           "file": {
> +#               "driver": "file",
> +#               "filename": "test.qcow2"
> +#            }
> +#       }
> +#     }
>  # <- { "return": {} }
>  #
>  # 2.
>  # -> { "execute": "blockdev-add",
>  #      "arguments": {
> -#          "options": {
>  #            "driver": "qcow2",
>  #            "node-name": "node0",
>  #            "discard": "unmap",
>  #            "cache": {
> -#                "direct": true,
> -#                "writeback": true
> +#                "direct": true
>  #            },
>  #            "file": {
>  #                "driver": "file",
> @@ -2936,7 +2939,6 @@
>  #                    "filename": "/dev/fdset/4"
>  #                }
>  #            }
> -#          }
>  #        }
>  #      }
>  #
> @@ -2964,14 +2966,12 @@
>  #
>  # -> { "execute": "blockdev-add",
>  #      "arguments": {
> -#          "options": {
>  #              "driver": "qcow2",
>  #              "node-name": "node0",
>  #              "file": {
>  #                  "driver": "file",
>  #                  "filename": "test.qcow2"
>  #              }
> -#          }
>  #      }
>  #    }
>  # <- { "return": {} }
> -- 
> 2.9.3
> 
> 

The alignments are a bit odd now but the syntax looks correct. Is it worth to
reindent while we are at it?

Fam
