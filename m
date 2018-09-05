Received: from eggs.gnu.org ([2001:4830:134:3::10]:43809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxZDj-00023j-Sk
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxZ3H-00029a-7h
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:45:03 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-32-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-32-mreitz@redhat.com>
Date: Wed, 05 Sep 2018 16:44:22 +0200
Message-ID: <w51wos0rol5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 31/31] iotests: Test json:{}
 filenames of internal BDSs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:28 PM CEST, Max Reitz wrote:
> +        vm.shutdown()
> +
> +        #assert top_name[:5] == 'json:'
> +        #top_options = json.loads(top_name[5:])
> +
> +        #if filter_node_name:
> +        #    # This should be present and set
> +        #    assert top_options['backing']['driver'] == 'commit_top'
> +        #    # And the mid image is commit_top's backing image
> +        #    mid_options = top_options['backing']['backing']
> +        #else:
> +        #    # The mid image should appear as the immediate backing BDS
> +        #    # of top
> +        #    mid_options = top_options['backing']
> +
> +        #assert mid_options['driver'] == iotests.imgfmt
> +        #assert mid_options['file']['filename'] == mid_img_path

What's with all these commented lines? I don't see how you are checking
the filename in this test, it's also not in the output file.

Berto
