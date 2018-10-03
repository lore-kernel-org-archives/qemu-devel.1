Received: from eggs.gnu.org ([2001:4830:134:3::10]:40603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gn8-0005QH-LY
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7gn3-0000bQ-Pp
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7gn3-0000ak-Is
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:02:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so6027166wrr.4
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:02:09 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-10-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c1bae99-edd6-8844-2f3f-045c9ef36c7f@redhat.com>
Date: Wed, 3 Oct 2018 15:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/12] tests/qom-proplist: check class
 properties iterator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/09/2018 09:59, Marc-André Lureau wrote:
> This test failed before "fix iterating properties over a class".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/check-qom-proplist.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 8e1b9c27f3..7ed16b704b 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -565,6 +565,14 @@ static void test_dummy_iterator(void)
>      object_unparent(OBJECT(dobj));
>  }
>  
> +static void test_dummy_class_iterator(void)
> +{
> +    ObjectPropertyIterator iter;
> +    ObjectClass *klass = object_class_by_name(TYPE_DUMMY);
> +
> +    object_class_property_iter_init(&iter, klass);
> +    test_dummy_prop_iterator(&iter);
> +}
>  
>  static void test_dummy_delchild(void)
>  {
> @@ -636,6 +644,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/qom/proplist/badenum", test_dummy_badenum);
>      g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
>      g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
> +    g_test_add_func("/qom/proplist/class_iterator", test_dummy_class_iterator);
>      g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
>      g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
