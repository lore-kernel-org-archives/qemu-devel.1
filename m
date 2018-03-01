Received: from eggs.gnu.org ([2001:4830:134:3::10]:37222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRqo-0006zK-EH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRql-0005zu-QS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:18:38 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:55875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erRql-0005zH-JE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:18:35 -0500
Received: by mail-wm0-x229.google.com with SMTP id q83so13608796wme.5
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:18:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-10-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <191cbbe9-7074-68b6-8f36-b9ed5ac2c133@redhat.com>
Date: Thu, 1 Mar 2018 18:18:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-10-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/15] qio: non-default context for
 threaded qtask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> + * @context: the context to run the complete hook

Please note the behavior for NULL context here, too.

Paolo

>   * Run a task in a background thread. When @worker
>   * returns it will call qio_task_complete() in
> - * the main event thread context.
> + * the event thread context that provided.
>   */
>  void qio_task_run_in_thread(QIOTask *task,
>                              QIOTaskWorker worker,
>                              gpointer opaque,
> -                            GDestroyNotify destroy);
> +                            GDestroyNotify destroy,
> +                            GMainContext *context);
