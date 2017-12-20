Received: from eggs.gnu.org ([2001:4830:134:3::10]:50514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRmxq-00023d-3z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRmxm-0003sg-0M
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:35:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRmxl-0003rE-QV
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 17:35:45 -0500
References: <20171218132439.2772-1-miika9764@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7579578e-2e0f-a6bb-f5be-ae7dfbafd6c4@redhat.com>
Date: Wed, 20 Dec 2017 16:35:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171218132439.2772-1-miika9764@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] input: add missing JIS keys to virtio
 input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miika S <miika9764@gmail.com>, qemu-devel@nongnu.org

On 12/18/2017 07:24 AM, Miika S wrote:
> Signed-off-by: Miika S <miika9764@gmail.com>
> ---
>   hw/input/virtio-input-hid.c | 7 +++++++
>   qapi/ui.json                | 2 +-
>   ui/keycodemapdb             | 2 +-
>   3 files changed, 9 insertions(+), 2 deletions(-)

When sending a multi-patch series, please remember to include the 0/3 
cover letter.  'git config format.coverletter auto' can make this task 
easier to remember.


>   
>   static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 07b468f625..da4be505ac 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -775,7 +775,7 @@
>               'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
>               'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
>               'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
> -            'ro', 'hiragana', 'henkan', 'yen',
> +            'ro', 'hiragana', 'muhenkan', 'henkan', 'katakanahiragana', 'yen',
>               'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
>               'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
>               'volumeup', 'volumedown', 'mediaselect',

Missing documentation that calls out which enum values were added in 2.12.

> diff --git a/ui/keycodemapdb b/ui/keycodemapdb
> index 10739aa260..05dad417e9 160000
> --- a/ui/keycodemapdb
> +++ b/ui/keycodemapdb
> @@ -1 +1 @@
> -Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
> +Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357

Generally, the commit message body should call out that a submodule 
change alongside other changes is intentional.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
